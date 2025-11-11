<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.7, < 2.0.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 2.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.43 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.43.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim"></a> [apim](#module\_apim) | ./module/apim | n/a |
| <a name="module_apim_subscriptions"></a> [apim\_subscriptions](#module\_apim\_subscriptions) | ./module/subscriptions | n/a |
| <a name="module_apis"></a> [apis](#module\_apis) | ./module/apis | n/a |
| <a name="module_cosmosdb"></a> [cosmosdb](#module\_cosmosdb) | ./module/cosmosdb | n/a |
| <a name="module_eventhub"></a> [eventhub](#module\_eventhub) | ./module/eventhub | n/a |
| <a name="module_id"></a> [id](#module\_id) | ./module/rbac | n/a |
| <a name="module_logicapp"></a> [logicapp](#module\_logicapp) | ./module/logicapp | n/a |
| <a name="module_monitoring"></a> [monitoring](#module\_monitoring) | ./module/monitoring | n/a |
| <a name="module_openai"></a> [openai](#module\_openai) | ./module/openai | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./module/networking | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_definitions"></a> [api\_definitions](#input\_api\_definitions) | A map of API definitions for deployment to API Management.<br/><br/>    Each key in the map is used as the API name, and the object values define the API properties:<br/>    - **api\_path** (string, required): The public path of the API (e.g., "search", "openai").<br/>    - **display\_name** (string, required): The friendly display name for the API in APIM.<br/>    - **description** (string, required): A description of the API.<br/>    - **content\_format** (string, optional, default = "openapi"): The format of the API definition.<br/>    - **api\_revision** (string, optional, default = "1"): The revision number for the API.<br/>    - **subscription\_key\_name** (string, optional, default = "api-key"): The subscription key header/query parameter name.<br/>    - **isPreview** (bool, optional, default = false) Let's you re-use the stable xml policy, for a preview spec.<br/><br/>    The module automatically sets file paths for the OpenAPI specification and API policy documents as:<br/>    - `./module/apis/policies/<api_name>/<api_name>-spec.yaml`<br/>    - `./module/apis/policies/<api_name>/<api_name>-policy.xml` | <pre>map(object({<br/>    api_path              = string<br/>    display_name          = string<br/>    description           = string<br/>    content_format        = optional(string, "openapi")<br/>    api_revision          = optional(string, "1")<br/>    subscription_key_name = optional(string, "api-key")<br/>    isPreview             = optional(bool, false)<br/>  }))</pre> | n/a | yes |
| <a name="input_apim_backends"></a> [apim\_backends](#input\_apim\_backends) | List of API Management backends.<br/><br/>    Each backend entry defines:<br/>    - **name** (string, required): Backend identifier used in APIM policies.<br/>    - **protocol** (string, required): Backend protocol (e.g., http, https).<br/>    - **url** (string, required): Fully qualified URL of the backend service. | <pre>list(object({<br/>    name     = string<br/>    protocol = string<br/>    url      = string<br/>  }))</pre> | `[]` | no |
| <a name="input_apim_cache_version"></a> [apim\_cache\_version](#input\_apim\_cache\_version) | This value must be updated, everytime there is a new OpenAI instance, or a deployed model | `string` | `"v3"` | no |
| <a name="input_apim_subnet_address_prefix"></a> [apim\_subnet\_address\_prefix](#input\_apim\_subnet\_address\_prefix) | CIDR block for the subnet hosting the Azure API Management (APIM) instance (e.g., 10.253.129.0/27). | `string` | n/a | yes |
| <a name="input_apim_subscriptions"></a> [apim\_subscriptions](#input\_apim\_subscriptions) | List of API Management subscriptions and their associated products.<br/><br/>    Each entry defines:<br/>    - **product\_id** (string, required): Identifier for the APIM product.<br/>    - **product\_display\_name** (string, required): Display name for the product.<br/>    - **product\_published** (bool, optional, default = true): Whether the product is published in APIM.<br/><br/>    - **subscription\_id** (string, required): Identifier for the subscription.<br/>    - **subscription\_display\_name** (string, required): Display name of the subscription.<br/>    - **subscription\_state** (string, optional, default = "active"): Subscription state (e.g., active, suspended).<br/>    - **subscription\_allow\_tracing** (bool, optional, default = false): Whether tracing/debugging is enabled for this subscription. | <pre>list(object({<br/>    product_id           = string<br/>    product_display_name = string<br/>    product_published    = optional(bool, true)<br/><br/>    subscription_id            = string<br/>    subscription_display_name  = string<br/>    subscription_state         = optional(string, "active")<br/>    subscription_allow_tracing = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_appName"></a> [appName](#input\_appName) | The name of the application or workload. Used as part of resource naming and tagging. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment of the workload. Must be one of: production, development, test, or dta. | `string` | n/a | yes |
| <a name="input_function_app_subnet_address_prefix"></a> [function\_app\_subnet\_address\_prefix](#input\_function\_app\_subnet\_address\_prefix) | CIDR block for the subnet used by the Azure Function App (e.g., 10.253.129.64/27). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | Instance identifier for resource uniqueness. Commonly used for multi-instance or multi-region deployments (e.g., 01, 02, weu, neu). | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region where resources will be deployed (e.g., westeurope, eastus). | `string` | n/a | yes |
| <a name="input_openai_deployments"></a> [openai\_deployments](#input\_openai\_deployments) | A map of Azure OpenAI deployments, keyed by deployment name (e.g., `openai01`).<br/><br/>    Each map entry defines:<br/>    - **location** (string, required): Azure region where the OpenAI resource is deployed.<br/>    - **model\_deployments** (list, required): A list of model deployments associated with this OpenAI instance.<br/><br/>    Each model deployment object includes:<br/>    - **name** (string, required): The logical name of the model deployment.<br/>    - **model** (object, required): Model configuration, including:<br/>      - `format` (string): Deployment format (e.g., OpenAI, Chat).<br/>      - `name` (string): Model name (e.g., gpt-35-turbo, gpt-4o-mini).<br/>      - `version` (string): Model version (e.g., 1106, 2024-05-01).<br/>    - **sku** (object, optional): SKU configuration for dedicated deployments. Includes:<br/>      - `name` (string): SKU name (e.g., S0).<br/>      - `capacity` (number): The instance capacity.<br/>    - **raiPolicyName** (string, optional): Responsible AI policy name to be applied. | <pre>map(object({<br/>    location = string<br/>    model_deployments = list(object({<br/>      name = string<br/>      model = object({<br/>        format  = string<br/>        name    = string<br/>        version = string<br/>      })<br/>      sku = optional(object({<br/>        name     = string<br/>        capacity = number<br/>      }))<br/>      raiPolicyName = optional(string)<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_private_endpoint_subnet_address_prefix"></a> [private\_endpoint\_subnet\_address\_prefix](#input\_private\_endpoint\_subnet\_address\_prefix) | CIDR block for the subnet dedicated to private endpoints (e.g., 10.253.129.32/27). | `string` | n/a | yes |
| <a name="input_vnet_address_prefix"></a> [vnet\_address\_prefix](#input\_vnet\_address\_prefix) | CIDR block for the virtual network (e.g., 10.253.129.0/25). Must be large enough to contain three /27 subnets. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->