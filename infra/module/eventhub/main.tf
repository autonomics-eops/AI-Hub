resource "azurerm_eventhub_namespace" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  capacity                      = var.capacity
  public_network_access_enabled = var.public_network_access_enabled

  tags = merge(var.tags, { "jde-service-name" = var.name })
}

resource "azurerm_eventhub" "this" {
  name            = var.eventhub_name
  namespace_id    = azurerm_eventhub_namespace.this.id
  partition_count = 1

  status = "Active"

  retention_description {
    cleanup_policy          = "Delete"
    retention_time_in_hours = 168
  }
}

resource "azurerm_private_endpoint" "this" {
  name                = var.eventhub_private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-${var.eventhub_private_endpoint_name}"
    private_connection_resource_id = azurerm_eventhub_namespace.this.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dns-zone-group"
    private_dns_zone_ids = [var.eventhub_dns_zone_id]
  }

  tags = merge(var.tags, { "jde-service-name" = var.name })
}

