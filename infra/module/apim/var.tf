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
  description = "Name of API Management instance"
  type        = string
}

variable "sku" {
  description = "value"
  type        = string
  default     = "StandardV2_1"
}

variable "publisher_name" {
  description = "API Management Publisher Name"
  type        = string
  default     = "JDE-IT-AIHub"
}

variable "publisher_email" {
  description = "API Management Publisher Email"
  type        = string
  default     = "eslam.mahmoud@jdecoffee.com"
}

variable "cacheVersion" {
  description = "API Management Local Cache Identifer for Routes and Clusters"
  type        = string
}

variable "apim_backends" {
  description = <<EOT
    List of API Management backends.  

    Each backend entry defines:  
    - **name** (string, required): Backend identifier used in APIM policies.  
    - **protocol** (string, required): Backend protocol (e.g., http, https).  
    - **url** (string, required): Fully qualified URL of the backend service.  
    EOT

  type = list(object({
    name     = string
    protocol = string
    url      = string
  }))
  default = []
}

variable "apim_subscriptions" {
  description = <<EOT
    List of API Management subscriptions and their associated products.  

    Each entry defines:  
    - **product_id** (string, required): Identifier for the APIM product.  
    - **product_display_name** (string, required): Display name for the product.  
    - **product_published** (bool, optional, default = true): Whether the product is published in APIM.  

    - **subscription_id** (string, required): Identifier for the subscription.  
    - **subscription_display_name** (string, required): Display name of the subscription.  
    - **subscription_state** (string, optional, default = "active"): Subscription state (e.g., active, suspended).  
    - **subscription_allow_tracing** (bool, optional, default = false): Whether tracing/debugging is enabled for this subscription.  
    EOT

  type = list(object({
    product_id           = string
    product_display_name = string
    product_published    = optional(bool, true)

    subscription_id            = string
    subscription_display_name  = string
    subscription_state         = optional(string, "active")
    subscription_allow_tracing = optional(bool, false)
  }))
  default = []
}

variable "eventhub_name" {
  description = "The name of the Event Hub used for the logger."
  type        = string
}

variable "eventhub_connection_string" {
  description = "The connection string for the Event Hub."
  type        = string
  sensitive   = true
}

variable "eventhub_resourceid" {
  description = "The full Azure resource ID of the Event Hub"
  type        = string
}

variable "application_insights_connection_string" {
  description = "The connection string for Application Insights."
  type        = string
  sensitive   = true
}

variable "application_insights_instrumentation_key" {
  description = "The connection string for Application Insights."
  type        = string
  sensitive   = true
}

variable "application_insights_resourceid" {
  description = "The full Azure resource ID of the Application Insights instance."
  type        = string
}

variable "uami_client_id" {
  description = "User Assigned Identity ClientId"
  type        = string
}

variable "uami_resource_id" {
  description = "User Assigned Identity ResourceId"
  type        = string
}

variable "tenant_id" {
  description = "EntraId TenantId"
  type        = string
}

variable "subnet_id" {
  description = "SubnetId to deploy API Management"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Event Hub resources"
  type        = map(string)
  default     = {}
}
