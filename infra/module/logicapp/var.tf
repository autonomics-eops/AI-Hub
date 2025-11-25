variable "app_service_plan_name" {
  description = "Name of the service plan to deploy"
  type        = string
}

variable "application_insights_name" {
  description = "Name of the application insights resource to use"
  type        = string
}

variable "application_insights_connection_string" {
  description = "Application Insights resource connection string"
  type        = string
  sensitive   = true
}

variable "application_insights_key" {
  description = "Application Insights instrumentation key"
  type        = string
  sensitive   = true
}

variable "logic_app_name" {
  description = "Name of the logicapp to deploy"
  type        = string
}

variable "storage_name" {
  description = "Name of the storage account to deploy"
  type        = string
}

variable "share_name" {
  description = "Name of the file share to create in the storage"
  type        = string
}

variable "eventhub_fqdn" {
  description = "FQDN of the Event Hub Namespace"
  type        = string
}

variable "eventhub_name" {
  description = "Name of the event hub"
  type        = string
}

variable "eventhub_connection_string" {
  description = "Connection string for Event Hub"
  type        = string
  sensitive   = true
}

variable "cosmosdb_account_name" {
  description = "CosmosDB account name"
  type        = string
}

variable "cosmosdb_database_name" {
  description = "CosmosDB database name"
  type        = string
}

variable "cosmosdb_config_container_name" {
  description = "CosmosDB 'config' container name"
  type        = string
}

variable "cosmosdb_usage_container_name" {
  description = "CosmosDB 'usage' container name"
  type        = string
}

variable "cosmosdb_connection_string" {
  description = "Connection string for CosmosDB"
  type        = string
  sensitive   = true
}

variable "cosmosdb_resourceid" {
  description = "Resource ID of cosmosdb account"
  type        = string
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Enable or disable public access. Use 'False' to disable."
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "Subnet ID for the logic app outbound"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
