output "apim_name" {
  description = "Name of the API Management Instance"
  value       = azurerm_api_management.this.name
}

output "apim_id" {
  description = "ResourceId of the API Management Instance"
  value       = azurerm_api_management.this.id
}

output "apim_rg" {
  description = "Name of Resource Group for the API Management Instance"
  value       = azurerm_api_management.this.resource_group_name
}
