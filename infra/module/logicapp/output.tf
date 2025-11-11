output "webapp_identity_principal_id" {
  description = "The principal ID of the system-assigned managed identity for the Logic App Standard"
  value       = azurerm_logic_app_standard.this.identity[0].principal_id
}

output "azure_monitor_logs_api_id" {
  description = "AzureMonitorLogs ManagedApi ResourceId"
  value       = azapi_resource.azure_monitor_logs.body["properties"]["api"]["id"]
}

output "azure_monitor_runtime_url" {
  value = azapi_resource.azure_monitor_logs.output.properties.connectionRuntimeUrl
}
