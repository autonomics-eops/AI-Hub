terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = ">= 2.6"
    }
  }
}

resource "azurerm_api_management" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email

  sku_name = var.sku

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [var.uami_resource_id]
  }

  protocols {
    http2_enabled = false
  }

  security {}

  virtual_network_type = "External"

  virtual_network_configuration { subnet_id = var.subnet_id }

  tags = merge(var.tags, { "jde-service-name" = var.name })
}

resource "azurerm_api_management_backend" "this" {
  for_each = {
    for backend in var.apim_backends : backend.name => backend
  }

  name                = each.value.name
  resource_group_name = azurerm_api_management.this.resource_group_name
  api_management_name = azurerm_api_management.this.name
  protocol            = each.value.protocol
  url                 = each.value.url
}

resource "azurerm_api_management_logger" "appinsights" {
  name                = "appinsights-logger"
  api_management_name = azurerm_api_management.this.name
  resource_group_name = azurerm_api_management.this.resource_group_name
  description         = "Application Insights logger for API observability"

  application_insights {
    connection_string = var.application_insights_connection_string
  }

  resource_id = var.application_insights_resourceid

  buffered = false
}

resource "azurerm_api_management_logger" "eventhub" {
  name                = "usage-eh-logger"
  api_management_name = azurerm_api_management.this.name
  resource_group_name = azurerm_api_management.this.resource_group_name
  description         = "Event Hub logger for OpenAI usage metrics"

  eventhub {
    name              = var.eventhub_name
    connection_string = var.eventhub_connection_string
  }

  resource_id = var.eventhub_resourceid
}

resource "azapi_resource" "logger_azuremonitor" {
  type      = "Microsoft.ApiManagement/service/loggers@2024-06-01-preview"
  name      = "azuremonitor"
  parent_id = azurerm_api_management.this.id

  body = {
    properties = {
      loggerType  = "azureMonitor"
      isBuffered  = true
      description = "Azure Monitor logger for Activity Logs"
      resourceId  = null
    }
  }
}

resource "azurerm_api_management_policy_fragment" "this" {
  for_each = {
    for file in fileset("${path.module}/fragments", "*.xml") :
    trimsuffix(file, ".xml") => file
  }

  name              = each.key
  api_management_id = azurerm_api_management.this.id

  value = trimspace(file("${path.module}/fragments/${each.value}"))

  depends_on = [
    azurerm_api_management_logger.appinsights,
    azurerm_api_management_logger.eventhub,
    azurerm_api_management_named_value.audience,
    azurerm_api_management_named_value.client-id,
    azurerm_api_management_named_value.entra-auth,
    azurerm_api_management_named_value.tenant-id,
    azurerm_api_management_named_value.uami-client-id,
    azurerm_api_management_named_value.cache-version
  ]
}

