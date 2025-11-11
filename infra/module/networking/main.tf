resource "azurerm_private_dns_zone" "dns" {
  for_each = toset(var.private_dns_zone_names)

  name                = each.key
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  tags                = merge(var.tags, { azd-service-name = var.nsg_name })
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowPublicAccess"
    priority                   = 3000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowAPIMManagement"
    priority                   = 3010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "ApiManagement"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowAPIMLoadBalancer"
    priority                   = 3020
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "6390"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowAzureTrafficManager"
    priority                   = 3030
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "AzureTrafficManager"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowStorage"
    priority                   = 3000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Storage"
  }

  security_rule {
    name                       = "AllowSql"
    priority                   = 3010
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Sql"
  }

  security_rule {
    name                       = "AllowKeyVault"
    priority                   = 3020
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureKeyVault"
  }

  security_rule {
    name                       = "AllowMonitor"
    priority                   = 3030
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["1886", "443"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureMonitor"
  }
}

resource "azurerm_route_table" "apim_route_table" {
  name                = var.apim_route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge(var.tags, { azd-service-name = var.apim_route_table_name })

  route {
    name           = "apim-management"
    address_prefix = "ApiManagement"
    next_hop_type  = "Internet"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  address_space       = [var.vnet_address_prefix]
  resource_group_name = var.resource_group_name
  tags                = merge(var.tags, { azd-service-name = var.name })
}

resource "azurerm_subnet" "apim" {
  name                 = var.apim_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.apim_subnet_address_prefix]


  delegation {
    name = "Microsoft.Web/serverFarms"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  service_endpoints = var.enable_service_endpoints_for_apim ? [
    "Microsoft.AzureActiveDirectory",
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.ServiceBus",
    "Microsoft.Sql",
    "Microsoft.Storage"
  ] : null
}

resource "azurerm_subnet" "private_endpoint" {
  name                 = var.private_endpoint_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_endpoint_subnet_address_prefix]

  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
}

resource "azurerm_subnet" "function_app" {
  name                 = var.function_app_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.function_app_subnet_address_prefix]

  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true

  delegation {
    name = "Microsoft.Web/serverFarms"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
  service_endpoints = var.enable_service_endpoints_for_apim ? [
    "Microsoft.AzureActiveDirectory",
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.ServiceBus",
    "Microsoft.Sql",
    "Microsoft.Storage"
  ] : null
}

resource "azurerm_subnet_network_security_group_association" "apim" {
  subnet_id                 = azurerm_subnet.apim.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "private_endpoint" {
  subnet_id                 = azurerm_subnet.private_endpoint.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "function_app" {
  subnet_id                 = azurerm_subnet.function_app.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_links" {
  for_each = toset(var.private_dns_zone_names)

  name                  = "${each.key}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dns[each.key].name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = false

  tags = var.tags
}
