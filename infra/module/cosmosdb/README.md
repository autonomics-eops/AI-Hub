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
| [azurerm_cosmosdb_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_sql_container.pricing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_sql_container.streaming](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_sql_container.usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_sql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database) | resource |
| [azurerm_cosmosdb_sql_role_assignment.uami_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_role_assignment) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | Name of the Cosmos DB account | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Primary container name | `string` | n/a | yes |
| <a name="input_cosmosdb_dns_zone_id"></a> [cosmosdb\_dns\_zone\_id](#input\_cosmosdb\_dns\_zone\_id) | Private DNS zone ID for Cosmos DB | `string` | n/a | yes |
| <a name="input_cosmosdb_private_endpoint_name"></a> [cosmosdb\_private\_endpoint\_name](#input\_cosmosdb\_private\_endpoint\_name) | Name for the Cosmos DB private endpoint | `string` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Cosmos DB database name | `string` | n/a | yes |
| <a name="input_default_consistency_level"></a> [default\_consistency\_level](#input\_default\_consistency\_level) | Consistency level for Cosmos DB | `string` | `"Session"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region for deployment | `string` | n/a | yes |
| <a name="input_max_interval_in_seconds"></a> [max\_interval\_in\_seconds](#input\_max\_interval\_in\_seconds) | Max interval for BoundedStaleness | `number` | `5` | no |
| <a name="input_max_staleness_prefix"></a> [max\_staleness\_prefix](#input\_max\_staleness\_prefix) | Max staleness prefix for BoundedStaleness | `number` | `100` | no |
| <a name="input_pricing_container_name"></a> [pricing\_container\_name](#input\_pricing\_container\_name) | Pricing container name | `string` | n/a | yes |
| <a name="input_primary_region"></a> [primary\_region](#input\_primary\_region) | Primary geo-location for Cosmos DB | `string` | n/a | yes |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | Subnet ID for the private endpoint | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Set to 'True' to enable public network access | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_streaming_export_config_container_name"></a> [streaming\_export\_config\_container\_name](#input\_streaming\_export\_config\_container\_name) | Streaming export configuration container name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_user_assigned_identity_principal_id"></a> [user\_assigned\_identity\_principal\_id](#input\_user\_assigned\_identity\_principal\_id) | Principal ID of the user-assigned managed identity | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cosmosdb_account_endpoint"></a> [cosmosdb\_account\_endpoint](#output\_cosmosdb\_account\_endpoint) | Cosmos DB endpoint URI |
| <a name="output_cosmosdb_account_name"></a> [cosmosdb\_account\_name](#output\_cosmosdb\_account\_name) | Name of the Cosmos DB account |
| <a name="output_cosmosdb_connection_string"></a> [cosmosdb\_connection\_string](#output\_cosmosdb\_connection\_string) | CosmosDB Connection String |
| <a name="output_cosmosdb_database_name"></a> [cosmosdb\_database\_name](#output\_cosmosdb\_database\_name) | Name of the Cosmos DB SQL database |
| <a name="output_cosmosdb_pricing_container_name"></a> [cosmosdb\_pricing\_container\_name](#output\_cosmosdb\_pricing\_container\_name) | CosmosDB Container Name: Pricing |
| <a name="output_cosmosdb_resource_id"></a> [cosmosdb\_resource\_id](#output\_cosmosdb\_resource\_id) | CosmosDB ResourceId |
| <a name="output_cosmosdb_streaming_container_name"></a> [cosmosdb\_streaming\_container\_name](#output\_cosmosdb\_streaming\_container\_name) | CosmosDB Container Name: Streaming |
| <a name="output_cosmosdb_usage_container_name"></a> [cosmosdb\_usage\_container\_name](#output\_cosmosdb\_usage\_container\_name) | CosmosDB Container Name: Usage |
<!-- END_TF_DOCS -->