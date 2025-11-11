resource "azurerm_resource_group" "rg" {
  name     = local.resourceNames["rg"]
  location = var.location

  tags = local.tags
}

module "vnet" {
  source = "./module/networking"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = local.resourceNames["vnet"]

  nsg_name              = local.resourceNames["nsg"]
  apim_route_table_name = local.resourceNames["rt"]

  apim_subnet_name             = "snet-apim_${local.resourceSuffix}"
  private_endpoint_subnet_name = "snet-pe_${local.resourceSuffix}"
  function_app_subnet_name     = "snet-app_${local.resourceSuffix}"

  vnet_address_prefix                    = var.vnet_address_prefix
  apim_subnet_address_prefix             = var.apim_subnet_address_prefix
  private_endpoint_subnet_address_prefix = var.private_endpoint_subnet_address_prefix
  function_app_subnet_address_prefix     = var.function_app_subnet_address_prefix

  private_dns_zone_names = local.private_dns_zone_names

  tags = local.tags
}

module "id" {
  source = "./module/rbac"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = local.resourceNames["id"]
  resource_group_id   = azurerm_resource_group.rg.id

  identity_roles = local.identity_roles

  tags = local.tags
}

module "monitoring" {
  source = "./module/monitoring"

  resource_group_name              = azurerm_resource_group.rg.name
  location                         = azurerm_resource_group.rg.location
  log_analytics_name               = local.resourceNames["law"]
  application_insights_name        = local.resourceNames["appi"]
  monitoring_dns_zone_id           = module.vnet.private_dns_zone_ids["privatelink.monitor.azure.com"]
  private_endpoint_subnet_id       = module.vnet.private_endpoint_subnet_id
  monitoring_private_endpoint_name = "pep-ampls_${local.resourceSuffix}"

  tags = local.tags
}

module "openai" {
  for_each = var.openai_deployments

  source = "./module/openai"

  name                = "${each.key}-${var.appName}-${local.shortEnvironment[var.environment]}-${local.shortLocation[each.value.location]}-${var.instance}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg.name

  managed_identity_id = module.id.identity_resource_id

  sku_name = "S0" # default at account level

  deployments = each.value.model_deployments

  public_network_access_enabled = false
  private_endpoint_subnet_id    = module.vnet.private_endpoint_subnet_id
  openai_private_endpoint_name  = "pep-${each.key}_${local.resourceSuffix}"
  openai_dns_zone_id            = module.vnet.private_dns_zone_ids["privatelink.openai.azure.com"]

  tags = local.tags
}

module "eventhub" {
  source = "./module/eventhub"

  resource_group_name           = azurerm_resource_group.rg.name
  location                      = var.location
  name                          = local.resourceNames["eventhub_namespace"]
  public_network_access_enabled = false

  sku                            = "Standard"
  capacity                       = 1
  eventhub_name                  = local.resourceNames["eventhub"]
  eventhub_private_endpoint_name = "pep-evh_${local.resourceSuffix}"
  eventhub_dns_zone_id           = module.vnet.private_dns_zone_ids["privatelink.servicebus.windows.net"]

  private_endpoint_subnet_id = module.vnet.private_endpoint_subnet_id

  tags = local.tags
}

module "logicapp" {
  source = "./module/logicapp"

  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  app_service_plan_name = local.resourceNames["asp"]
  logic_app_name        = local.resourceNames["app"]
  storage_name          = local.resourceNames["storage"]
  share_name            = local.resourceNames["storage_share"]

  public_network_access_enabled = true
  subnet_id                     = module.vnet.logic_app_subnet_id

  application_insights_name              = module.monitoring.application_insights_name
  application_insights_key               = module.monitoring.application_insights_instrumentation_key
  application_insights_connection_string = module.monitoring.application_insights_connection_string

  cosmosdb_account_name          = module.cosmosdb.cosmosdb_account_name
  cosmosdb_database_name         = module.cosmosdb.cosmosdb_database_name
  cosmosdb_connection_string     = module.cosmosdb.cosmosdb_connection_string
  cosmosdb_config_container_name = module.cosmosdb.cosmosdb_streaming_container_name
  cosmosdb_usage_container_name  = module.cosmosdb.cosmosdb_usage_container_name
  cosmosdb_resourceid            = module.cosmosdb.cosmosdb_resource_id

  eventhub_name              = module.eventhub.eventhub_name
  eventhub_fqdn              = "${module.eventhub.eventhub_namespace_name}.servicebus.windows.net"
  eventhub_connection_string = module.eventhub.eventhub_connection_string

  #private_endpoint_subnet_id = module.vnet.private_endpoint_subnet_id

  tags = local.tags
}

module "cosmosdb" {
  source = "./module/cosmosdb"

  resource_group_name                    = azurerm_resource_group.rg.name
  location                               = var.location
  account_name                           = local.resourceNames["cosmos"]
  database_name                          = local.resourceNames["cosmos_database"]
  container_name                         = local.resourceNames["cosmos_container_usage"]
  pricing_container_name                 = local.resourceNames["cosmos_container_pricing"]
  streaming_export_config_container_name = local.resourceNames["cosmos_container_export"]
  default_consistency_level              = "Session"
  max_interval_in_seconds                = 5
  max_staleness_prefix                   = 100
  primary_region                         = var.location

  public_network_access_enabled  = false
  cosmosdb_private_endpoint_name = "pep-cosmos_${local.resourceSuffix}"
  cosmosdb_dns_zone_id           = module.vnet.private_dns_zone_ids["privatelink.documents.azure.com"]
  private_endpoint_subnet_id     = module.vnet.private_endpoint_subnet_id

  user_assigned_identity_principal_id = module.id.identity_principal_id

  tags = local.tags
}

module "apim" {
  source = "./module/apim"

  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  name                = local.resourceNames["apim"]

  subnet_id = module.vnet.apim_subnet_id

  application_insights_connection_string   = module.monitoring.application_insights_connection_string
  application_insights_resourceid          = module.monitoring.application_insights_resource_id
  application_insights_instrumentation_key = module.monitoring.application_insights_instrumentation_key

  eventhub_name              = module.eventhub.eventhub_name
  eventhub_connection_string = module.eventhub.eventhub_connection_string
  eventhub_resourceid        = module.eventhub.eventhub_resourceid

  tenant_id        = data.azurerm_client_config.current.tenant_id
  uami_resource_id = module.id.identity_resource_id
  uami_client_id   = module.id.identity_client_id

  apim_backends      = var.apim_backends
  apim_subscriptions = var.apim_subscriptions

  cacheVersion = var.apim_cache_version

  tags = local.tags

  depends_on = [module.logicapp]
}

module "apis" {
  source   = "./module/apis"
  for_each = var.api_definitions

  resource_group_name = module.apim.apim_rg
  api_management_name = module.apim.apim_name

  api_name         = each.key
  api_display_name = each.value.display_name
  api_description  = each.value.description
  api_path         = each.value.api_path

  api_revision          = each.value.api_revision
  subscription_key_name = each.value.subscription_key_name
  content_format        = each.value.content_format

  openapi_specification_file = "./module/apis/policies/${each.key}/${each.key}-spec.yaml"
  policy_document_file       = "./module/apis/policies/${each.key}/${each.key}-policy.xml"
  isPreview                  = coalesce(each.value.isPreview, false)
}

module "apim_subscriptions" {
  source   = "./module/subscriptions"
  for_each = { for sub in var.apim_subscriptions : sub.product_id => sub }

  resource_group_name = module.apim.apim_rg
  api_management_name = module.apim.apim_name
  api_name            = module.apis["azure-openai-service-api"].api_name

  product_id                 = each.value.product_id
  product_display_name       = each.value.product_display_name
  product_published          = each.value.product_published
  subscription_id            = each.value.subscription_id
  subscription_display_name  = each.value.subscription_display_name
  subscription_state         = each.value.subscription_state
  subscription_allow_tracing = each.value.subscription_allow_tracing
}
