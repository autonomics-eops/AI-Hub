output "identity_principal_id" {
  description = "User-Assigned Identity PrincipalId (ObjectId)"
  value       = azurerm_user_assigned_identity.this.principal_id
}

output "identity_client_id" {
  description = "User-Assigned Identity ClientId (ApplicationId)"
  value       = azurerm_user_assigned_identity.this.client_id
}

output "identity_tenant_id" {
  description = "EntraID TenantId"
  value       = azurerm_user_assigned_identity.this.tenant_id
}

output "identity_resource_id" {
  description = "User-Assigned Identity ResourceId"
  value       = azurerm_user_assigned_identity.this.id
}

output "identity_name" {
  description = "User-Assigned Identity Name"
  value       = azurerm_user_assigned_identity.this.name
}

output "identity_resource_group_name" {
  description = "User-Assigned Identity ResourceGroupName"
  value       = azurerm_user_assigned_identity.this.resource_group_name
}
