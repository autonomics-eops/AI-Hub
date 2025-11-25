variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "api_management_name" {
  description = "The name of the API Management service."
  type        = string
}

variable "api_name" {
  description = "The name of the API."
  type        = string
}

variable "api_revision" {
  description = "The revision of the API."
  type        = string
  default     = "1"
}

variable "api_display_name" {
  description = "Display name of the API."
  type        = string
}

variable "api_path" {
  description = "Path for the API."
  type        = string
}

variable "api_description" {
  description = "API description."
  type        = string
}

variable "api_protocols" {
  description = "List of protocols supported."
  type        = list(string)
  default     = ["https"]
}

variable "service_url" {
  description = "Backend service URL."
  type        = string
  default     = ""
}

variable "content_format" {
  description = "Format of the OpenAPI spec (swagger-link-json, openapi-link, openapi+json, openapi+yaml)."
  type        = string
}

variable "openapi_specification_file" {
  description = "Path to the OpenAPI specification file."
  type        = string
}

variable "subscription_required" {
  description = "Whether a subscription is required."
  type        = bool
  default     = true
}

variable "subscription_key_name" {
  description = "Custom subscription key header name."
  type        = string
}

variable "api_type" {
  description = "API type (e.g., 'http', 'soap', 'graphql')."
  type        = string
  default     = "http"
}

variable "policy_document_file" {
  description = "Path to the API policy file."
  type        = string
}

variable "isPreview" {
  description = "Whether API uses the stable or preview spec"
  type        = bool
  default     = false
}
