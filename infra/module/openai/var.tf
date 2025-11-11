variable "resource_group_name" {
  description = "The name of the resource group where the Cognitive Services (OpenAI) instance and its related resources (e.g., private DNS zone) will be deployed."
  type        = string
}

variable "name" {
  description = "The name of the Cognitive Services (OpenAI) instance. This will be used as the resource name in Azure."
  type        = string
}

variable "location" {
  description = "Azure region where the Cognitive Services (OpenAI) instance will be deployed (e.g., westeurope, eastus)."
  type        = string
}

variable "managed_identity_id" {
  description = "The full resource ID of the managed identity to be assigned to the Cognitive Services (OpenAI) instance. This identity is used for authentication and integration with other services."
  type        = string
}

variable "public_network_access_enabled" {
  description = "Controls whether the Cognitive Services (OpenAI) instance is accessible via public endpoints. Set to `false` to restrict access to private endpoints only."
  type        = bool
  default     = false
}

variable "sku_name" {
  description = "The SKU name for the Cognitive Services (OpenAI) instance (e.g., 'S0'). Determines pricing tier and capacity options."
  type        = string
  default     = "S0"
}

variable "kind" {
  description = "The kind of Cognitive Services resource. For Azure OpenAI, this must be set to 'OpenAI'."
  type        = string
  default     = "OpenAI"
}

variable "deployments" {
  description = <<EOT
    List of model deployment configurations for the Cognitive Services (OpenAI) instance.  

    Each deployment object defines:  
    - **name** (string, required): The name of the model deployment.  
    - **model** (object, required): The model configuration, including:  
      - `format` (string): The format of the model (e.g., OpenAI, Chat).  
      - `name` (string): The name of the model (e.g., gpt-35-turbo, gpt-4o-mini).  
      - `version` (string): The version of the model (e.g., 1106, 2024-05-01).  
    - **sku** (object, optional): SKU configuration for dedicated deployments. Includes:  
      - `name` (string): The SKU name (e.g., S0).  
      - `capacity` (number): The deployment capacity.  
    - **raiPolicyName** (string, optional): Responsible AI policy name to be applied to the deployment.  
    EOT

  type = list(object({
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
}

variable "openai_private_endpoint_name" {
  description = "The name of the private endpoint resource to be created for the Cognitive Services (OpenAI) instance."
  type        = string
}

variable "openai_dns_zone_id" {
  description = "The resource ID of the private DNS zone to associate with the OpenAI private endpoint (e.g., `/subscriptions/<subId>/resourceGroups/<rgName>/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com`)."
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "The resource ID of the subnet where the OpenAI private endpoint will be deployed. This subnet must be dedicated for private endpoints."
  type        = string
}

variable "tags" {
  description = "A map of key-value pairs (tags) to apply to all deployed resources for cost tracking and resource organization."
  type        = map(string)
}
