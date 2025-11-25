terraform {
  required_version = ">= 1.1.7, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.43"
    }

    azapi = {
      source  = "Azure/azapi"
      version = ">= 2.6"
    }
  }

  backend "azurerm" {
    storage_account_name = "sttfscf1f29544prdwe001"
    container_name       = "tfstate"
    key                  = "aihublz.tfstate"
    resource_group_name  = "AI-hub"
    subscription_id      = "4859ec56-96d2-47b5-ae52-3b74174759e1"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "4859ec56-96d2-47b5-ae52-3b74174759e1"
}
