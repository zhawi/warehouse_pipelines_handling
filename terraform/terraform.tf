##
# Terraform Configuration
##

terraform {

  backend "azurerm" {
    key = "github.terraform.tfstate"
  }

  required_version = ">=1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

##
# Providers
##

provider "azurerm" {
  features {}
}