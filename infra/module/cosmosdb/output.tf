output "cosmosdb_account_name" {
  description = "Name of the Cosmos DB account"
  value       = azurerm_cosmosdb_account.this.name
}

output "cosmosdb_resource_id" {
  description = "CosmosDB ResourceId"
  value       = azurerm_cosmosdb_account.this.id
}

output "cosmosdb_database_name" {
  description = "Name of the Cosmos DB SQL database"
  value       = azurerm_cosmosdb_sql_database.this.name
}

output "cosmosdb_account_endpoint" {
  description = "Cosmos DB endpoint URI"
  value       = azurerm_cosmosdb_account.this.endpoint
}

output "cosmosdb_usage_container_name" {
  description = "CosmosDB Container Name: Usage"
  value       = azurerm_cosmosdb_sql_container.usage.name
}

output "cosmosdb_pricing_container_name" {
  description = "CosmosDB Container Name: Pricing"
  value       = azurerm_cosmosdb_sql_container.pricing.name
}

output "cosmosdb_streaming_container_name" {
  description = "CosmosDB Container Name: Streaming"
  value       = azurerm_cosmosdb_sql_container.streaming.name
}

output "cosmosdb_connection_string" {
  description = "CosmosDB Connection String"
  value       = azurerm_cosmosdb_account.this.primary_sql_connection_string
  sensitive   = true
}
