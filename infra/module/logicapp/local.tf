terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = ">= 2.6"
    }
  }
}

data "azurerm_client_config" "current" {}

locals {
  azure_monitor_log_name        = "azuremonitorlogs"
  azure_monitor_log_access_name = "azuremonitorlogs-access"
}
