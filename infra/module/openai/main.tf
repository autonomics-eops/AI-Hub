resource "azurerm_cognitive_account" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.kind
  sku_name            = var.sku_name

  custom_subdomain_name         = lower(var.name)
  public_network_access_enabled = var.public_network_access_enabled

  network_acls {
    default_action = "Deny"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.managed_identity_id]
  }

  tags = merge(var.tags, { "jde-service-name" = var.name })
}

resource "azurerm_cognitive_deployment" "this" {
  for_each = { for d in var.deployments : d.name => d }

  name                 = each.key
  cognitive_account_id = azurerm_cognitive_account.this.id
  model {
    format  = each.value.model.format
    name    = each.value.model.name
    version = each.value.model.version
  }
  rai_policy_name = try(each.value.raiPolicyName, null)
  sku {
    name     = try(each.value.sku.name, "Standard")
    capacity = try(each.value.sku.capacity, "250")
  }
}

resource "azurerm_private_endpoint" "this" {
  name                = var.openai_private_endpoint_name
  location            = azurerm_cognitive_account.this.location
  resource_group_name = azurerm_cognitive_account.this.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-${var.openai_private_endpoint_name}"
    private_connection_resource_id = azurerm_cognitive_account.this.id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dns-zone-group"
    private_dns_zone_ids = [var.openai_dns_zone_id]
  }

  tags = var.tags
}
