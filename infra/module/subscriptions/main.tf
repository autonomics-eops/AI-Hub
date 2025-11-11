## Default Product per Subscription
resource "azurerm_api_management_product" "this" {
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name

  product_id   = var.product_id
  display_name = var.product_display_name
  published    = var.product_published

  description = var.subscription_display_name

  subscription_required = true
  approval_required     = false
}

## Give OpenAI API Access for the default product
resource "azurerm_api_management_product_api" "this" {
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name

  product_id = azurerm_api_management_product.this.product_id
  api_name   = var.api_name
}

## Create subscription and associate to the product
resource "azurerm_api_management_subscription" "this" {
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name

  display_name    = var.subscription_display_name
  subscription_id = var.subscription_id
  allow_tracing   = var.subscription_allow_tracing
  state           = var.subscription_state

  product_id = azurerm_api_management_product.this.id
}

