resource "azurerm_log_analytics_workspace" "this" {
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = merge(var.tags, { "jde-service-name" = var.log_analytics_name })
}

resource "azurerm_application_insights" "this" {
  name                = var.application_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.this.id

  tags = merge(var.tags, { "jde-service-name" = var.application_insights_name })
}

resource "azurerm_monitor_private_link_scope" "this" {
  name                = "ampls-monitoring"
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ingestion_access_mode = "Open"
  query_access_mode     = "Open"
}

resource "azurerm_monitor_private_link_scoped_service" "appi" {
  name                = "appi-amplsservice"
  resource_group_name = azurerm_monitor_private_link_scope.this.resource_group_name
  scope_name          = azurerm_monitor_private_link_scope.this.name
  linked_resource_id  = azurerm_application_insights.this.id
}

resource "azurerm_monitor_private_link_scoped_service" "law" {
  name                = "law-amplsservice"
  resource_group_name = azurerm_monitor_private_link_scope.this.resource_group_name
  scope_name          = azurerm_monitor_private_link_scope.this.name
  linked_resource_id  = azurerm_log_analytics_workspace.this.id
}

resource "azurerm_private_endpoint" "this" {
  name                = var.monitoring_private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-${var.monitoring_private_endpoint_name}"
    private_connection_resource_id = azurerm_monitor_private_link_scope.this.id
    subresource_names              = ["azuremonitor"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dns-zone-group"
    private_dns_zone_ids = [var.monitoring_dns_zone_id]
  }

  tags = merge(var.tags, { "jde-service-name" = var.log_analytics_name })
}
