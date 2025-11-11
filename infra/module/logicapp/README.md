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
| [azapi_resource.azure_monitor_logs](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.azure_monitor_logs_access](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_cosmosdb_sql_role_assignment.webapp_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_role_assignment) | resource |
| [azurerm_logic_app_standard.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_standard) | resource |
| [azurerm_role_assignment.eventhub_owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.monitor_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_share.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | Name of the service plan to deploy | `string` | n/a | yes |
| <a name="input_application_insights_connection_string"></a> [application\_insights\_connection\_string](#input\_application\_insights\_connection\_string) | Application Insights resource connection string | `string` | n/a | yes |
| <a name="input_application_insights_key"></a> [application\_insights\_key](#input\_application\_insights\_key) | Application Insights instrumentation key | `string` | n/a | yes |
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Name of the application insights resource to use | `string` | n/a | yes |
| <a name="input_cosmosdb_account_name"></a> [cosmosdb\_account\_name](#input\_cosmosdb\_account\_name) | CosmosDB account name | `string` | n/a | yes |
| <a name="input_cosmosdb_config_container_name"></a> [cosmosdb\_config\_container\_name](#input\_cosmosdb\_config\_container\_name) | CosmosDB 'config' container name | `string` | n/a | yes |
| <a name="input_cosmosdb_connection_string"></a> [cosmosdb\_connection\_string](#input\_cosmosdb\_connection\_string) | Connection string for CosmosDB | `string` | n/a | yes |
| <a name="input_cosmosdb_database_name"></a> [cosmosdb\_database\_name](#input\_cosmosdb\_database\_name) | CosmosDB database name | `string` | n/a | yes |
| <a name="input_cosmosdb_resourceid"></a> [cosmosdb\_resourceid](#input\_cosmosdb\_resourceid) | Resource ID of cosmosdb account | `string` | n/a | yes |
| <a name="input_cosmosdb_usage_container_name"></a> [cosmosdb\_usage\_container\_name](#input\_cosmosdb\_usage\_container\_name) | CosmosDB 'usage' container name | `string` | n/a | yes |
| <a name="input_eventhub_connection_string"></a> [eventhub\_connection\_string](#input\_eventhub\_connection\_string) | Connection string for Event Hub | `string` | n/a | yes |
| <a name="input_eventhub_fqdn"></a> [eventhub\_fqdn](#input\_eventhub\_fqdn) | FQDN of the Event Hub Namespace | `string` | n/a | yes |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | Name of the event hub | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region for deployment | `string` | n/a | yes |
| <a name="input_logic_app_name"></a> [logic\_app\_name](#input\_logic\_app\_name) | Name of the logicapp to deploy | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable or disable public access. Use 'False' to disable. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_share_name"></a> [share\_name](#input\_share\_name) | Name of the file share to create in the storage | `string` | n/a | yes |
| <a name="input_storage_name"></a> [storage\_name](#input\_storage\_name) | Name of the storage account to deploy | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID for the logic app outbound | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_monitor_logs_api_id"></a> [azure\_monitor\_logs\_api\_id](#output\_azure\_monitor\_logs\_api\_id) | AzureMonitorLogs ManagedApi ResourceId |
| <a name="output_azure_monitor_runtime_url"></a> [azure\_monitor\_runtime\_url](#output\_azure\_monitor\_runtime\_url) | n/a |
| <a name="output_webapp_identity_principal_id"></a> [webapp\_identity\_principal\_id](#output\_webapp\_identity\_principal\_id) | The principal ID of the system-assigned managed identity for the Logic App Standard |
<!-- END_TF_DOCS -->