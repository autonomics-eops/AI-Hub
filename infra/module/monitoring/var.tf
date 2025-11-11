variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "log_analytics_name" {
  type = string
}

variable "application_insights_name" {
  type = string
}

variable "private_endpoint_subnet_id" {
  type = string
}

variable "monitoring_private_endpoint_name" {
  description = "Name of the private endpoint for the monitoring service"
  type        = string
}

variable "monitoring_dns_zone_id" {
  type = string
}
