terraform {
  required_version = ">=1.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  # https://github.com/hashicorp/terraform-provider-azurerm/issues/3358
  # our SP cannot register surplus azure providers for like Media or AI or chat-bots
  skip_provider_registration = true

  features {}
}

