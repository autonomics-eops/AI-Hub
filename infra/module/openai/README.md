<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cognitive_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) | resource |
| [azurerm_cognitive_deployment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployments"></a> [deployments](#input\_deployments) | List of model deployment configurations for the Cognitive Services (OpenAI) instance.<br/><br/>    Each deployment object defines:<br/>    - **name** (string, required): The name of the model deployment.<br/>    - **model** (object, required): The model configuration, including:<br/>      - `format` (string): The format of the model (e.g., OpenAI, Chat).<br/>      - `name` (string): The name of the model (e.g., gpt-35-turbo, gpt-4o-mini).<br/>      - `version` (string): The version of the model (e.g., 1106, 2024-05-01).<br/>    - **sku** (object, optional): SKU configuration for dedicated deployments. Includes:<br/>      - `name` (string): The SKU name (e.g., S0).<br/>      - `capacity` (number): The deployment capacity.<br/>    - **raiPolicyName** (string, optional): Responsible AI policy name to be applied to the deployment. | <pre>list(object({<br/>    name = string<br/>    model = object({<br/>      format  = string<br/>      name    = string<br/>      version = string<br/>    })<br/>    sku = optional(object({<br/>      name     = string<br/>      capacity = number<br/>    }))<br/>    raiPolicyName = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_kind"></a> [kind](#input\_kind) | The kind of Cognitive Services resource. For Azure OpenAI, this must be set to 'OpenAI'. | `string` | `"OpenAI"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the Cognitive Services (OpenAI) instance will be deployed (e.g., westeurope, eastus). | `string` | n/a | yes |
| <a name="input_managed_identity_id"></a> [managed\_identity\_id](#input\_managed\_identity\_id) | The full resource ID of the managed identity to be assigned to the Cognitive Services (OpenAI) instance. This identity is used for authentication and integration with other services. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Cognitive Services (OpenAI) instance. This will be used as the resource name in Azure. | `string` | n/a | yes |
| <a name="input_openai_dns_zone_id"></a> [openai\_dns\_zone\_id](#input\_openai\_dns\_zone\_id) | The resource ID of the private DNS zone to associate with the OpenAI private endpoint (e.g., `/subscriptions/<subId>/resourceGroups/<rgName>/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com`). | `string` | n/a | yes |
| <a name="input_openai_private_endpoint_name"></a> [openai\_private\_endpoint\_name](#input\_openai\_private\_endpoint\_name) | The name of the private endpoint resource to be created for the Cognitive Services (OpenAI) instance. | `string` | n/a | yes |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | The resource ID of the subnet where the OpenAI private endpoint will be deployed. This subnet must be dedicated for private endpoints. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Controls whether the Cognitive Services (OpenAI) instance is accessible via public endpoints. Set to `false` to restrict access to private endpoints only. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the Cognitive Services (OpenAI) instance and its related resources (e.g., private DNS zone) will be deployed. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for the Cognitive Services (OpenAI) instance (e.g., 'S0'). Determines pricing tier and capacity options. | `string` | `"S0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of key-value pairs (tags) to apply to all deployed resources for cost tracking and resource organization. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apim_fqdn"></a> [apim\_fqdn](#output\_apim\_fqdn) | API Management Service HTTPs Endpoint |
<!-- END_TF_DOCS -->