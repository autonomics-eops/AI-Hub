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
| [azurerm_role_assignment.cosmos_operator](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.cosmos_operator](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_identity_roles"></a> [identity\_roles](#input\_identity\_roles) | n/a | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location for all resources | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the virtual network | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | ResourceId of the resource group | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_identity_client_id"></a> [identity\_client\_id](#output\_identity\_client\_id) | User-Assigned Identity ClientId (ApplicationId) |
| <a name="output_identity_name"></a> [identity\_name](#output\_identity\_name) | User-Assigned Identity Name |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | User-Assigned Identity PrincipalId (ObjectId) |
| <a name="output_identity_resource_group_name"></a> [identity\_resource\_group\_name](#output\_identity\_resource\_group\_name) | User-Assigned Identity ResourceGroupName |
| <a name="output_identity_resource_id"></a> [identity\_resource\_id](#output\_identity\_resource\_id) | User-Assigned Identity ResourceId |
| <a name="output_identity_tenant_id"></a> [identity\_tenant\_id](#output\_identity\_tenant\_id) | EntraID TenantId |
<!-- END_TF_DOCS -->