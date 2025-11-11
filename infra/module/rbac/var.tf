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

variable "resource_group_id" {
  description = "ResourceId of the resource group"
  type        = string
}

variable "identity_roles" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}
