resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Windows"
  sku_name            = "WS1"


  tags = merge(var.tags, { "jde-service-name" = var.app_service_plan_name })
}

resource "azurerm_storage_account" "this" {
  name                              = var.storage_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  allow_nested_items_to_be_public   = false
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = var.public_network_access_enabled

  tags = merge(var.tags, { "jde-service-name" = var.storage_name })
}

resource "azurerm_storage_share" "this" {
  name               = var.share_name
  storage_account_id = azurerm_storage_account.this.id
  quota              = 50
}

resource "azurerm_logic_app_standard" "this" {
  name                = var.logic_app_name
  location            = var.location
  resource_group_name = azurerm_service_plan.this.resource_group_name

  public_network_access = var.public_network_access_enabled ? "Enabled" : "Disabled"

  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key
  storage_account_share_name = azurerm_storage_share.this.name
  app_service_plan_id        = azurerm_service_plan.this.id

  site_config {
    always_on              = true
    vnet_route_all_enabled = true
    ftps_state             = "FtpsOnly"

    cors {
      allowed_origins = [
        "https://portal.azure.com",
        "https://ms.portal.azure.com"
      ]
      support_credentials = false
    }

    scm_min_tls_version      = "1.2"
    dotnet_framework_version = "v6.0"

  }
  use_extension_bundle = true
  version              = "~4"
  https_only           = true

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"              = "dotnet"
    "WEBSITE_NODE_DEFAULT_VERSION"          = "~18"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.application_insights_connection_string
    "WEBSITE_CONTENTOVERVNET"               = "1"

    "EventHub_fullyQualifiedNamespace" = var.eventhub_fqdn
    "EventHub_name"                    = var.eventhub_name
    "EventHub_connectionString"        = var.eventhub_connection_string

    "CosmosDBAccount"                = var.cosmosdb_account_name
    "CosmosDBDatabase"               = var.cosmosdb_database_name
    "CosmosDBContainerConfig"        = var.cosmosdb_config_container_name
    "CosmosDBContainerUsage"         = var.cosmosdb_usage_container_name
    "AzureCosmosDB_connectionString" = var.cosmosdb_connection_string
    "AppInsights_SubscriptionId"     = data.azurerm_client_config.current.subscription_id
    "AppInsights_ResourceGroup"      = var.resource_group_name
    "AppInsights_Name"               = var.application_insights_name

    "AzureMonitor_Resource_Id"        = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Web/connections/${local.azure_monitor_log_name}"
    "AzureMonitor_Api_Id"             = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.Web/locations/${var.location}/managedApis/${local.azure_monitor_log_name}"
    "AzureMonitor_ConnectRuntime_Url" = "https://4836487ff90335e4.11.common.logic-westeurope.azure-apihub.net/apim/${local.azure_monitor_log_name}/4345217873d547d98c91cd68eb48eeaf"
    #azapi_resource.azure_monitor_logs.output.properties.connectionRuntimeUrl
  }

  identity {
    type = "SystemAssigned"
  }

  virtual_network_subnet_id = var.subnet_id

  tags = merge({
    "jde-service-name" = var.logic_app_name
  }, var.tags)
}

resource "azurerm_role_assignment" "monitor_reader" {
  scope                            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"
  principal_id                     = azurerm_logic_app_standard.this.identity[0].principal_id
  role_definition_id               = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.Authorization/roleDefinitions/43d0d8ad-25c7-4714-9337-8ba259a9fe05"
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "eventhub_owner" {
  scope                            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"
  principal_id                     = azurerm_logic_app_standard.this.identity[0].principal_id
  role_definition_id               = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.Authorization/roleDefinitions/f526a384-b230-433a-b45c-95f59c4a2dec"
  skip_service_principal_aad_check = true
}

resource "azurerm_cosmosdb_sql_role_assignment" "webapp_assignment" {
  name                = uuidv5("6ba7b811-9dad-11d1-80b4-00c04fd430c8", "${azurerm_logic_app_standard.this.identity[0].principal_id}-${var.cosmosdb_account_name}")
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  role_definition_id  = "${var.cosmosdb_resourceid}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id        = azurerm_logic_app_standard.this.identity[0].principal_id
  scope               = "${var.cosmosdb_resourceid}/dbs"
}

resource "azapi_resource" "azure_monitor_logs" {
  type      = "Microsoft.Web/connections@2016-06-01"
  name      = local.azure_monitor_log_name
  location  = var.location
  parent_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"

  body = {
    kind = "V2"
    properties = {
      displayName       = "AzureMonitor"
      connectionState   = "Enabled"
      authenticatedUser = {}
      parameterValueSet = {
        name   = "managedIdentityAuth"
        values = {}
      }
      alternativeParameterValues = {}
      customParameterValues      = {}
      api = {
        id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.Web/locations/${var.location}/managedApis/azuremonitorlogs"
      }
    }
  }
  response_export_values    = ["properties.connectionRuntimeUrl"]
  schema_validation_enabled = false
  tags                      = var.tags
}

resource "azapi_resource" "azure_monitor_logs_access" {
  type      = "Microsoft.Web/connections/accessPolicies@2016-06-01"
  name      = local.azure_monitor_log_access_name
  parent_id = azapi_resource.azure_monitor_logs.id

  body = {
    location = var.location
    properties = {
      principal = {
        type = "ActiveDirectory"
        identity = {
          tenantId = azurerm_logic_app_standard.this.identity[0].tenant_id
          objectId = azurerm_logic_app_standard.this.identity[0].principal_id
        }
      }
    }
  }

  schema_validation_enabled = false
}
