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
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_private_dns_zone.dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.dns_links](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_route_table.apim_route_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.function_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.function_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_route_table_name"></a> [apim\_route\_table\_name](#input\_apim\_route\_table\_name) | n/a | `string` | n/a | yes |
| <a name="input_apim_subnet_address_prefix"></a> [apim\_subnet\_address\_prefix](#input\_apim\_subnet\_address\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_apim_subnet_name"></a> [apim\_subnet\_name](#input\_apim\_subnet\_name) | n/a | `string` | n/a | yes |
| <a name="input_enable_service_endpoints_for_apim"></a> [enable\_service\_endpoints\_for\_apim](#input\_enable\_service\_endpoints\_for\_apim) | n/a | `bool` | `true` | no |
| <a name="input_function_app_subnet_address_prefix"></a> [function\_app\_subnet\_address\_prefix](#input\_function\_app\_subnet\_address\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_function_app_subnet_name"></a> [function\_app\_subnet\_name](#input\_function\_app\_subnet\_name) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location for all resources | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the virtual network | `string` | n/a | yes |
| <a name="input_nsg_name"></a> [nsg\_name](#input\_nsg\_name) | n/a | `string` | n/a | yes |
| <a name="input_private_dns_zone_names"></a> [private\_dns\_zone\_names](#input\_private\_dns\_zone\_names) | n/a | `list(string)` | n/a | yes |
| <a name="input_private_endpoint_subnet_address_prefix"></a> [private\_endpoint\_subnet\_address\_prefix](#input\_private\_endpoint\_subnet\_address\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_private_endpoint_subnet_name"></a> [private\_endpoint\_subnet\_name](#input\_private\_endpoint\_subnet\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vnet_address_prefix"></a> [vnet\_address\_prefix](#input\_vnet\_address\_prefix) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apim_subnet_id"></a> [apim\_subnet\_id](#output\_apim\_subnet\_id) | Subnet ResourceId of API Management Instance |
| <a name="output_apim_subnet_name"></a> [apim\_subnet\_name](#output\_apim\_subnet\_name) | Subnet Name for the API Management Instance |
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_logic_app_subnet_id"></a> [logic\_app\_subnet\_id](#output\_logic\_app\_subnet\_id) | SubnetId for the LogicApp |
| <a name="output_logic_app_subnet_name"></a> [logic\_app\_subnet\_name](#output\_logic\_app\_subnet\_name) | Subnet Name for the LogicApp |
| <a name="output_nsg_id"></a> [nsg\_id](#output\_nsg\_id) | n/a |
| <a name="output_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#output\_private\_dns\_zone\_ids) | Map of Private DNS Zone names to their IDs |
| <a name="output_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#output\_private\_endpoint\_subnet\_id) | SubnetId for PrivateEndpoints |
| <a name="output_private_endpoint_subnet_name"></a> [private\_endpoint\_subnet\_name](#output\_private\_endpoint\_subnet\_name) | Subnet Name for PrivateEndpoints |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | Virtual Network ResourceId |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | Virtual Network Name |
<!-- END_TF_DOCS -->