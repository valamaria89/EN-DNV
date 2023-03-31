terraform {
  required_version = "~> 1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.37"
      use_cli_credentials = true
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
  }

  backend "azurerm" {
    storage_account_name = "enmltfstatedevsawe"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}