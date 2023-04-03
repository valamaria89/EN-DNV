terraform {
  required_version = "~> 1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.37"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
  }

  backend "azurerm" {
    resource_group_name  = "en-mltfstate-dev-rg-we"
    storage_account_name = "enmltfstatedevsawe"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}