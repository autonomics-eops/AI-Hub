resource "azurerm_role_definition" "cosmos_operator" {
  name              = "role-cosmos_operator"
  scope             = var.resource_group_id
  description       = "Custom role to operate cosmosdb account"
  assignable_scopes = [var.resource_group_id]

  permissions {
    actions = [
      "Microsoft.DocumentDB/databaseAccounts/services/read",
      "Microsoft.DocumentDB/databaseAccounts/services/write",
      "Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions/read",
      "Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions/write",
    ]
    not_actions = []
  }
}

resource "azurerm_user_assigned_identity" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_role_assignment" "cosmos_operator" {
  scope              = var.resource_group_id
  role_definition_id = azurerm_role_definition.cosmos_operator.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.this.principal_id
}

resource "azurerm_role_assignment" "this" {
  for_each = toset(var.identity_roles)

  scope                = var.resource_group_id
  role_definition_name = each.value
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}
