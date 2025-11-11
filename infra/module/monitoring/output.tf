output "application_insights_name" {
  value       = azurerm_application_insights.this.name
  description = "Name of the Application Insights resource"
}

output "application_insights_resource_group_name" {
  value       = azurerm_application_insights.this.resource_group_name
  description = "Resource group of the Application Insights resource"
}

output "application_insights_instrumentation_key" {
  value       = azurerm_application_insights.this.instrumentation_key
  description = "Instrumentation Key of the Application Insights resource"
  sensitive   = true
}

output "application_insights_connection_string" {
  value       = azurerm_application_insights.this.connection_string
  description = "Connection string of the Application Insights resource"
  sensitive   = true
}

output "application_insights_resource_id" {
  value       = azurerm_application_insights.this.id
  description = "Resource ID of the Application Insights resource"
}

output "log_analytics_workspace_id" {
  value       = azurerm_log_analytics_workspace.this.id
  description = "Resource ID of the Log Analytics workspace"
}

output "log_analytics_workspace_name" {
  value       = azurerm_log_analytics_workspace.this.name
  description = "Name of the Log Analytics workspace"
}

output "monitor_private_link_scope_name" {
  value       = azurerm_monitor_private_link_scope.this.name
  description = "Name of the Private Link Scope resource"
}

output "monitor_private_link_scope_id" {
  value       = azurerm_monitor_private_link_scope.this.id
  description = "Resource ID of the Private Link Scope"
}
