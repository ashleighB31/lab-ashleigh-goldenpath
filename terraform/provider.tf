terraform {
  required_version = ">= 1.5.7"

  backend "azurerm" {
    resource_group_name  = "ashtfstates"
    storage_account_name = "ashleightf"
    container_name       = "tfstatedevops"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = "27f048cd-d37e-4655-8fbe-2e41b14d7327"
}
 