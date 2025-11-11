resource "azurerm_cosmosdb_account" "this" {
  name                          = lower(var.account_name)
  location                      = var.location
  resource_group_name           = var.resource_group_name
  offer_type                    = "Standard"
  kind                          = "GlobalDocumentDB"
  public_network_access_enabled = var.public_network_access_enabled
  consistency_policy {
    consistency_level       = var.default_consistency_level
    max_interval_in_seconds = var.default_consistency_level == "BoundedStaleness" ? var.max_interval_in_seconds : null
    max_staleness_prefix    = var.default_consistency_level == "BoundedStaleness" ? var.max_staleness_prefix : null
  }
  geo_location {
    location          = var.primary_region
    failover_priority = 0
  }
  is_virtual_network_filter_enabled = false

  backup {
    type                = "Periodic"
    storage_redundancy  = "Local"
    interval_in_minutes = 720
    retention_in_hours  = 24
  }

  capabilities {
    name = "EnableServerless"
  }

  tags = merge(var.tags, { "jde-service-name" = var.account_name })
}

resource "azurerm_cosmosdb_sql_database" "this" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
}

resource "azurerm_cosmosdb_sql_container" "usage" {
  name                  = var.container_name
  resource_group_name   = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.this.name
  database_name         = azurerm_cosmosdb_sql_database.this.name
  partition_key_paths   = ["/productName"]
  partition_key_version = 2
  throughput            = null
}

resource "azurerm_cosmosdb_sql_container" "pricing" {
  name                  = var.pricing_container_name
  resource_group_name   = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.this.name
  database_name         = azurerm_cosmosdb_sql_database.this.name
  partition_key_paths   = ["/model"]
  partition_key_version = 2
  throughput            = null
}

resource "azurerm_cosmosdb_sql_container" "streaming" {
  name                  = var.streaming_export_config_container_name
  resource_group_name   = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.this.name
  database_name         = azurerm_cosmosdb_sql_database.this.name
  partition_key_paths   = ["/type"]
  partition_key_version = 2
  throughput            = null
}

resource "azurerm_private_endpoint" "this" {
  name                = var.cosmosdb_private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-${var.cosmosdb_private_endpoint_name}"
    private_connection_resource_id = azurerm_cosmosdb_account.this.id
    subresource_names              = ["sql"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dns-zone-group"
    private_dns_zone_ids = [var.cosmosdb_dns_zone_id]
  }

  tags = var.tags
}

resource "azurerm_cosmosdb_sql_role_assignment" "uami_assignment" {
  name                = uuidv5("6ba7b811-9dad-11d1-80b4-00c04fd430c8", "${var.user_assigned_identity_principal_id}-${azurerm_cosmosdb_account.this.name}")
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  role_definition_id  = "${azurerm_cosmosdb_account.this.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id        = var.user_assigned_identity_principal_id
  scope               = "${azurerm_cosmosdb_account.this.id}/dbs"
}
