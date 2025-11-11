resource "azurerm_api_management_named_value" "audience" {
  name         = "audience"
  display_name = "audience"
  value        = "https://cognitiveservices.azure.com/.default"

  api_management_name = azurerm_api_management.this.name
  resource_group_name = azurerm_api_management.this.resource_group_name
}

resource "azurerm_api_management_named_value" "client-id" {
  name         = "client-id"
  display_name = "client-id"
  value        = var.uami_client_id

  api_management_name = azurerm_api_management.this.name
  resource_group_name = azurerm_api_management.this.resource_group_name
}

resource "azurerm_api_management_named_value" "uami-client-id" {
  name         = "uami-client-id"
  display_name = "uami-client-id"
  value        = var.uami_client_id

  api_management_name = azurerm_api_management.this.name
  resource_group_name = azurerm_api_management.this.resource_group_name
}

resource "azurerm_api_management_named_value" "tenant-id" {
  name         = "tenant-id"
  display_name = "tenant-id"
  value        = var.tenant_id

  api_management_name = azurerm_api_management.this.name
  resource_group_name = azurerm_api_management.this.resource_group_name
}

resource "azurerm_api_management_named_value" "entra-auth" {
  name         = "entra-auth"
  display_name = "entra-auth"
  value        = "false"

  api_management_name = azurerm_api_management.this.name
  resource_group_name = azurerm_api_management.this.resource_group_name
}

resource "azurerm_api_management_named_value" "cache-version" {
  name         = "cache-version"
  display_name = "cache-version"
  value        = var.cacheVersion
  secret       = false

  api_management_name = azurerm_api_management.this.name
  resource_group_name = azurerm_api_management.this.resource_group_name
}
