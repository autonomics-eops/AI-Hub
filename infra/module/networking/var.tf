variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location for all resources"
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the virtual network"
  type        = string
}

variable "nsg_name" {
  type = string
}

variable "apim_subnet_name" {
  type = string
}

variable "private_endpoint_subnet_name" {
  type = string
}

variable "function_app_subnet_name" {
  type = string
}

variable "apim_route_table_name" {
  type = string
}

variable "private_dns_zone_names" {
  type = list(string)
}

variable "vnet_address_prefix" {
  type = string
}

variable "apim_subnet_address_prefix" {
  type = string
}

variable "private_endpoint_subnet_address_prefix" {
  type = string
}

variable "function_app_subnet_address_prefix" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "enable_service_endpoints_for_apim" {
  type    = bool
  default = true
}
