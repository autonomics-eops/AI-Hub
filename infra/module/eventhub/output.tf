output "eventhub_namespace_name" {
  description = "Eventhub Namespace Name"
  value       = azurerm_eventhub_namespace.this.name
}

output "eventhub_name" {
  description = "Eventhub Name"
  value       = azurerm_eventhub.this.name
}

output "eventhub_namespace_resourceid" {
  description = "EventHub Namespace ResourceId"
  value       = azurerm_eventhub_namespace.this
}

output "eventhub_resourceid" {
  description = "EventHub ResourceId"
  value       = azurerm_eventhub.this.id
}

output "eventhub_connection_string" {
  description = "EventHub Namespace ConnectionString"
  value       = azurerm_eventhub_namespace.this.default_primary_connection_string
}
