output "virtual_network_id" {
  description = "Virtual Network ResourceId"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Virtual Network Name"
  value       = azurerm_virtual_network.vnet.name
}

output "apim_subnet_name" {
  description = "Subnet Name for the API Management Instance"
  value       = azurerm_subnet.apim.name
}

output "apim_subnet_id" {
  description = "Subnet ResourceId of API Management Instance"
  value       = azurerm_subnet.apim.id
}

output "private_endpoint_subnet_name" {
  description = "Subnet Name for PrivateEndpoints"
  value       = azurerm_subnet.private_endpoint.name
}

output "private_endpoint_subnet_id" {
  description = "SubnetId for PrivateEndpoints"
  value       = azurerm_subnet.private_endpoint.id
}

output "logic_app_subnet_name" {
  description = "Subnet Name for the LogicApp"
  value       = azurerm_subnet.function_app.name
}

output "logic_app_subnet_id" {
  description = "SubnetId for the LogicApp"
  value       = azurerm_subnet.function_app.id
}

output "location" {
  value = var.location
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

output "resource_group_name" {
  value = azurerm_virtual_network.vnet.resource_group_name
}

output "private_dns_zone_ids" {
  description = "Map of Private DNS Zone names to their IDs"
  value       = { for name, zone in azurerm_private_dns_zone.dns : name => zone.id }
}
