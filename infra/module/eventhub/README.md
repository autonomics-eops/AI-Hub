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
| [azurerm_eventhub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity"></a> [capacity](#input\_capacity) | Throughput units for the Event Hub SKU | `number` | `1` | no |
| <a name="input_eventhub_dns_zone_id"></a> [eventhub\_dns\_zone\_id](#input\_eventhub\_dns\_zone\_id) | Name of the private DNS zone for the Event Hub | `string` | n/a | yes |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | Name of the Event Hub instance under the namespace | `string` | `"ai-usage"` | no |
| <a name="input_eventhub_private_endpoint_name"></a> [eventhub\_private\_endpoint\_name](#input\_eventhub\_private\_endpoint\_name) | Name of the private endpoint for the Event Hub | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region for deployment | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the Event Hub Namespace | `string` | n/a | yes |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | ResourceId of the subnet to deploy private endpoints. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Controls public network access to the namespace. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Event Hub Namespace | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU tier for the Event Hub (e.g., 'Standard') | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the Event Hub resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventhub_connection_string"></a> [eventhub\_connection\_string](#output\_eventhub\_connection\_string) | EventHub Namespace ConnectionString |
| <a name="output_eventhub_name"></a> [eventhub\_name](#output\_eventhub\_name) | Eventhub Name |
| <a name="output_eventhub_namespace_name"></a> [eventhub\_namespace\_name](#output\_eventhub\_namespace\_name) | Eventhub Namespace Name |
| <a name="output_eventhub_namespace_resourceid"></a> [eventhub\_namespace\_resourceid](#output\_eventhub\_namespace\_resourceid) | EventHub Namespace ResourceId |
| <a name="output_eventhub_resourceid"></a> [eventhub\_resourceid](#output\_eventhub\_resourceid) | EventHub ResourceId |
<!-- END_TF_DOCS -->