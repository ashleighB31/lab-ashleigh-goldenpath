terraform {
  required_version = ">= 1.5.7"
  backend "azurerm" {
    resource_group_name  = "ashtfstates"
    storage_account_name = "ashleightf"
    container_name       = "tfstatedevops"
    key                  = "github-ashleigh-terraform-example.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

# #Create Resource Group
# resource "azurerm_resource_group" "tamops" {
#   name     = "ashtfstates"
#   location = "uksouth"
# }

#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "tamops-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.tamops.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.tamops.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.0.0/24"]
}

# Resource Group
resource "azurerm_resource_group" "tamops" {
  name     = "ashtfstates"
  location = "uksouth"
}
 
# Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = "ashleightf"
  resource_group_name      = "ashtfstates"
  location                 = "uksouth"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
 
# Role Assignment for the Service Principal (Storage Account Contributor)
resource "azurerm_role_assignment" "storage_account_contributor" {
  principal_id   = "200fc413-964d-4194-a663-f558e9e26332"  # Object ID of the service principal
  role_definition_name = "Storage Account Contributor"
  scope          = azurerm_storage_account.sa.id
}

resource "azurerm_role_assignment" "rg_role_assignment" {
  principal_id   = "200fc413-964d-4194-a663-f558e9e26332" # Object ID of the service principal
  role_definition_name = "Storage Account Contributor"
  scope          = azurerm_resource_group.tamops.id
}
