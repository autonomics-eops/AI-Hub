variable "account_name" {
  description = "Name of the Cosmos DB account"
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

variable "database_name" {
  description = "Cosmos DB database name"
  type        = string
}

variable "container_name" {
  description = "Primary container name"
  type        = string
}

variable "pricing_container_name" {
  description = "Pricing container name"
  type        = string
}

variable "streaming_export_config_container_name" {
  description = "Streaming export configuration container name"
  type        = string
}

variable "default_consistency_level" {
  description = "Consistency level for Cosmos DB"
  type        = string
  default     = "Session"
}

variable "max_interval_in_seconds" {
  description = "Max interval for BoundedStaleness"
  type        = number
  default     = 5
}

variable "max_staleness_prefix" {
  description = "Max staleness prefix for BoundedStaleness"
  type        = number
  default     = 100
}

variable "primary_region" {
  description = "Primary geo-location for Cosmos DB"
  type        = string
}

variable "cosmosdb_private_endpoint_name" {
  description = "Name for the Cosmos DB private endpoint"
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for the private endpoint"
  type        = string
}

variable "cosmosdb_dns_zone_id" {
  description = "Private DNS zone ID for Cosmos DB"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Set to 'True' to enable public network access"
  type        = bool
  default     = false
}

variable "user_assigned_identity_principal_id" {
  description = "Principal ID of the user-assigned managed identity"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
