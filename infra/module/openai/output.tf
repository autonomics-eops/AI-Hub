output "apim_fqdn" {
  description = "API Management Service HTTPs Endpoint"
  value       = azurerm_cognitive_account.this.endpoint
}
