<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 2.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | >= 2.6 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_resource.logger_azuremonitor](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_api_management.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |
| [azurerm_api_management_backend.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_backend) | resource |
| [azurerm_api_management_logger.appinsights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_logger) | resource |
| [azurerm_api_management_logger.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_logger) | resource |
| [azurerm_api_management_named_value.audience](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.cache-version](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.client-id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.entra-auth](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.tenant-id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_named_value.uami-client-id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_policy_fragment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_policy_fragment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_backends"></a> [apim\_backends](#input\_apim\_backends) | List of API Management backends.<br/><br/>    Each backend entry defines:<br/>    - **name** (string, required): Backend identifier used in APIM policies.<br/>    - **protocol** (string, required): Backend protocol (e.g., http, https).<br/>    - **url** (string, required): Fully qualified URL of the backend service. | <pre>list(object({<br/>    name     = string<br/>    protocol = string<br/>    url      = string<br/>  }))</pre> | `[]` | no |
| <a name="input_apim_subscriptions"></a> [apim\_subscriptions](#input\_apim\_subscriptions) | List of API Management subscriptions and their associated products.<br/><br/>    Each entry defines:<br/>    - **product\_id** (string, required): Identifier for the APIM product.<br/>    - **product\_display\_name** (string, required): Display name for the product.<br/>    - **product\_published** (bool, optional, default = true): Whether the product is published in APIM.<br/><br/>    - **subscription\_id** (string, required): Identifier for the subscription.<br/>    - **subscription\_display\_name** (string, required): Display name of the subscription.<br/>    - **subscription\_state** (string, optional, default = "active"): Subscription state (e.g., active, suspended).<br/>    - **subscription\_allow\_tracing** (bool, optional, default = false): Whether tracing/debugging is enabled for this subscription. | <pre>list(object({<br/>    product_id           = string<br/>    product_display_name = string<br/>    product_published    = optional(bool, true)<br/><br/>    subscription_id            = string<br/>    subscription_display_name  = string<br/>    subscription_state         = optional(string, "active")<br/>    subscription_allow_tracing = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_application_insights_connection_string"></a> [application\_insights\_connection\_string](#input\_application\_insights\_connection\_string) | The connection string for Application Insights. | `string` | n/a | yes |
| <a name="input_application_insights_instrumentation_key"></a> [application\_insights\_instrumentation\_key](#input\_application\_insights\_instrumentation\_key) | The connection string for Application Insights. | `string` | n/a | yes |
| <a name="input_application_insights_resourceid"></a> [application\_insights\_resourceid](#input\_application\_insights\_resourceid) | The full Azure resource ID of the Application Insights instance. | `string` | n/a | yes |
| <a name="input_cacheVersion"></a> [cacheVersion](#input\_cacheVersion) | API Management Local Cache Identifer for Routes and Clusters | `string` | n/a | yes |
| <a name="input_eventhub_connection_string"></a> [eventhub\_connection\_string](#input\_eventhub\_connection\_string) | The connection string for the Event Hub. | `string` | n/a | yes |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | The name of the Event Hub used for the logger. | `string` | n/a | yes |
| <a name="input_eventhub_resourceid"></a> [eventhub\_resourceid](#input\_eventhub\_resourceid) | The full Azure resource ID of the Event Hub | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location for all resources | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of API Management instance | `string` | n/a | yes |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | API Management Publisher Email | `string` | `"eslam.mahmoud@jdecoffee.com"` | no |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | API Management Publisher Name | `string` | `"JDE-IT-AIHub"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | value | `string` | `"StandardV2_1"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | SubnetId to deploy API Management | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the Event Hub resources | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | EntraId TenantId | `string` | n/a | yes |
| <a name="input_uami_client_id"></a> [uami\_client\_id](#input\_uami\_client\_id) | User Assigned Identity ClientId | `string` | n/a | yes |
| <a name="input_uami_resource_id"></a> [uami\_resource\_id](#input\_uami\_resource\_id) | User Assigned Identity ResourceId | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apim_id"></a> [apim\_id](#output\_apim\_id) | ResourceId of the API Management Instance |
| <a name="output_apim_name"></a> [apim\_name](#output\_apim\_name) | Name of the API Management Instance |
| <a name="output_apim_rg"></a> [apim\_rg](#output\_apim\_rg) | Name of Resource Group for the API Management Instance |
<!-- END_TF_DOCS -->