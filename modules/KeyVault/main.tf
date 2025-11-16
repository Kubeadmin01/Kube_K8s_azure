
resource "random_string" "prefix" {
  length  = 8
  upper   = false
  special = false
  numeric = true
}

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "KV" {
  name                        = "${random_string.prefix.id}-kv"
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_private_endpoint" "PE" {
  name                = "${azurerm_key_vault.KV.name}-pe"
  location            = azurerm_key_vault.KV.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.azurerm_subnet_id
  depends_on          = [azurerm_key_vault.KV]

  private_service_connection {
    name                           = "kube_psc"
    private_connection_resource_id = azurerm_key_vault.KV.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  tags = {
    environment = "DEV"
  }
} 
