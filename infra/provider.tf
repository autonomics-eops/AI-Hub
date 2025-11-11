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
    resource_group_name  = "rg-tfstate-prd-we-001"
    subscription_id      = "c6cb483d-5684-4a38-9d2f-9afb65dc672f"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "c6cb483d-5684-4a38-9d2f-9afb65dc672f"
}
