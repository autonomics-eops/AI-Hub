variable "appName" {
  type        = string
  description = "The name of the application or workload. Used as part of resource naming and tagging."
}

variable "location" {
  type        = string
  description = "Azure region where resources will be deployed (e.g., westeurope, eastus)."
}

variable "instance" {
  type        = string
  description = "Instance identifier for resource uniqueness. Commonly used for multi-instance or multi-region deployments (e.g., 01, 02, weu, neu)."
}

variable "environment" {
  type        = string
  description = "Deployment environment of the workload. Must be one of: production, development, test, or dta."
  validation {
    condition     = contains(["production", "development", "test", "dta"], var.environment)
    error_message = "Environment must be one of: production, development, test, dta."
  }
}

# Networking
variable "vnet_address_prefix" {
  type        = string
  description = "CIDR block for the virtual network (e.g., 10.253.129.0/25). Must be large enough to contain three /27 subnets."
}

variable "apim_subnet_address_prefix" {
  type        = string
  description = "CIDR block for the subnet hosting the Azure API Management (APIM) instance (e.g., 10.253.129.0/27)."
}

variable "private_endpoint_subnet_address_prefix" {
  type        = string
  description = "CIDR block for the subnet dedicated to private endpoints (e.g., 10.253.129.32/27)."
}

variable "function_app_subnet_address_prefix" {
  type        = string
  description = "CIDR block for the subnet used by the Azure Function App (e.g., 10.253.129.64/27)."
}

# OpenAI deployments
variable "openai_deployments" {
  description = <<EOT
    A map of Azure OpenAI deployments, keyed by deployment name (e.g., `openai01`).  

    Each map entry defines:  
    - **location** (string, required): Azure region where the OpenAI resource is deployed.  
    - **model_deployments** (list, required): A list of model deployments associated with this OpenAI instance.  

    Each model deployment object includes:  
    - **name** (string, required): The logical name of the model deployment.  
    - **model** (object, required): Model configuration, including:  
      - `format` (string): Deployment format (e.g., OpenAI, Chat).  
      - `name` (string): Model name (e.g., gpt-35-turbo, gpt-4o-mini).  
      - `version` (string): Model version (e.g., 1106, 2024-05-01).  
    - **sku** (object, optional): SKU configuration for dedicated deployments. Includes:  
      - `name` (string): SKU name (e.g., S0).  
      - `capacity` (number): The instance capacity.  
    - **raiPolicyName** (string, optional): Responsible AI policy name to be applied.  
    EOT

  type = map(object({
    location = string
    model_deployments = list(object({
      name = string
      model = object({
        format  = string
        name    = string
        version = string
      })
      sku = optional(object({
        name     = string
        capacity = number
      }))
      raiPolicyName = optional(string)
    }))
  }))
}

# APIM backends
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

# APIM APIs
variable "api_definitions" {
  description = <<EOT
    A map of API definitions for deployment to API Management.  

    Each key in the map is used as the API name, and the object values define the API properties:  
    - **api_path** (string, required): The public path of the API (e.g., "search", "openai").  
    - **display_name** (string, required): The friendly display name for the API in APIM.  
    - **description** (string, required): A description of the API.  
    - **content_format** (string, optional, default = "openapi"): The format of the API definition.  
    - **api_revision** (string, optional, default = "1"): The revision number for the API.  
    - **subscription_key_name** (string, optional, default = "api-key"): The subscription key header/query parameter name.  
    - **isPreview** (bool, optional, default = false) Let's you re-use the stable xml policy, for a preview spec.

    The module automatically sets file paths for the OpenAPI specification and API policy documents as:  
    - `./module/apis/policies/<api_name>/<api_name>-spec.yaml`  
    - `./module/apis/policies/<api_name>/<api_name>-policy.xml`  
    EOT

  type = map(object({
    api_path              = string
    display_name          = string
    description           = string
    content_format        = optional(string, "openapi")
    api_revision          = optional(string, "1")
    subscription_key_name = optional(string, "api-key")
    isPreview             = optional(bool, false)
  }))
}

# APIM Subscriptions and Products
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

variable "apim_cache_version" {
  type        = string
  default     = "v3"
  description = "This value must be updated, everytime there is a new OpenAI instance, or a deployed model"
}
