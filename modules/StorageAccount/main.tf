




resource "random_string" "prefix" {
  length  = 8
  upper   = false
  special = false
  numeric = true
}


resource "azurerm_storage_account" "SA" {
  name                     = "${random_string.prefix.id}sa"
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"

  tags = {
    environment = "DEV"
  }
}
# Create a private endpoint for the storage account


resource "azurerm_private_endpoint" "PE" {
  name                = "${azurerm_storage_account.SA.name}-pe"
  location            = azurerm_storage_account.SA.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.azurerm_subnet_id
  depends_on          = [azurerm_storage_account.SA]

  private_service_connection {
    name                           = "kube_psc"
    private_connection_resource_id = azurerm_storage_account.SA.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  tags = {
    environment = "DEV"
  }
} 