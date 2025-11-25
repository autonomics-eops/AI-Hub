variable "resource_group_name" {
  description = "Name of the Event Hub Namespace"
  type        = string
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
}

variable "name" {
  description = "Name of the Event Hub Namespace"
  type        = string
}

variable "sku" {
  description = "SKU tier for the Event Hub (e.g., 'Standard')"
  type        = string
  default     = "Standard"
}

variable "capacity" {
  description = "Throughput units for the Event Hub SKU"
  type        = number
  default     = 1
}

variable "eventhub_name" {
  description = "Name of the Event Hub instance under the namespace"
  type        = string
  default     = "ai-usage"
}

variable "public_network_access_enabled" {
  description = "Controls public network access to the namespace."
  type        = bool
  default     = false
}

variable "eventhub_private_endpoint_name" {
  description = "Name of the private endpoint for the Event Hub"
  type        = string
}

variable "eventhub_dns_zone_id" {
  description = "Name of the private DNS zone for the Event Hub"
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "ResourceId of the subnet to deploy private endpoints."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Event Hub resources"
  type        = map(string)
  default     = {}
}


