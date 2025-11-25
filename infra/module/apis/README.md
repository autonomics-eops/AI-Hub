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
| [azurerm_api_management_api.api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_description"></a> [api\_description](#input\_api\_description) | API description. | `string` | n/a | yes |
| <a name="input_api_display_name"></a> [api\_display\_name](#input\_api\_display\_name) | Display name of the API. | `string` | n/a | yes |
| <a name="input_api_management_name"></a> [api\_management\_name](#input\_api\_management\_name) | The name of the API Management service. | `string` | n/a | yes |
| <a name="input_api_name"></a> [api\_name](#input\_api\_name) | The name of the API. | `string` | n/a | yes |
| <a name="input_api_path"></a> [api\_path](#input\_api\_path) | Path for the API. | `string` | n/a | yes |
| <a name="input_api_protocols"></a> [api\_protocols](#input\_api\_protocols) | List of protocols supported. | `list(string)` | <pre>[<br/>  "https"<br/>]</pre> | no |
| <a name="input_api_revision"></a> [api\_revision](#input\_api\_revision) | The revision of the API. | `string` | `"1"` | no |
| <a name="input_api_type"></a> [api\_type](#input\_api\_type) | API type (e.g., 'http', 'soap', 'graphql'). | `string` | `"http"` | no |
| <a name="input_content_format"></a> [content\_format](#input\_content\_format) | Format of the OpenAPI spec (swagger-link-json, openapi-link, openapi+json, openapi+yaml). | `string` | n/a | yes |
| <a name="input_isPreview"></a> [isPreview](#input\_isPreview) | Whether API uses the stable or preview spec | `bool` | `false` | no |
| <a name="input_openapi_specification_file"></a> [openapi\_specification\_file](#input\_openapi\_specification\_file) | Path to the OpenAPI specification file. | `string` | n/a | yes |
| <a name="input_policy_document_file"></a> [policy\_document\_file](#input\_policy\_document\_file) | Path to the API policy file. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_service_url"></a> [service\_url](#input\_service\_url) | Backend service URL. | `string` | `""` | no |
| <a name="input_subscription_key_name"></a> [subscription\_key\_name](#input\_subscription\_key\_name) | Custom subscription key header name. | `string` | n/a | yes |
| <a name="input_subscription_required"></a> [subscription\_required](#input\_subscription\_required) | Whether a subscription is required. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_name"></a> [api\_name](#output\_api\_name) | API Management API Resource Name |
<!-- END_TF_DOCS -->