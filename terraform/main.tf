 data "azurerm_client_config" "current" {}
 
# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "ashtfstates"
  location = "uksouth"
}

 resource "azurerm_storage_account" "sa" {
  name                     = "ashleightf100"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
 
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
 
  depends_on = [azurerm_storage_account.sa]  # Ensure storage account is fully provisioned
}