resource "azurerm_api_management_api" "api" {
  name                = var.api_name
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name

  revision     = var.api_revision
  display_name = var.api_display_name
  path         = var.api_path != "" ? var.api_path : var.api_name
  description  = var.api_description != "" ? var.api_description : var.api_name
  protocols    = var.api_protocols
  service_url  = var.service_url != "" ? var.service_url : "https://to-be-replaced-by-policy"

  import {
    content_format = var.content_format
    content_value  = file(var.openapi_specification_file)
  }

  subscription_required = var.subscription_required

  subscription_key_parameter_names {
    header = var.subscription_key_name != "" ? var.subscription_key_name : "Ocp-Apim-Subscription-Key"
    query  = "subscription-key"
  }

  api_type = var.api_type

}

resource "azurerm_api_management_api_policy" "policy" {
  api_name            = azurerm_api_management_api.api.name
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name

  xml_content = file(var.isPreview ? replace(var.policy_document_file, "-preview", "") : var.policy_document_file)
}
