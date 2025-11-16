resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  # Conditional identity
  dynamic "identity" {
    for_each = var.enable_identity ? [1] : []
    content {
      type         = length(var.user_assigned_identity_ids) > 0 ? "UserAssigned" : "SystemAssigned"
      identity_ids = length(var.user_assigned_identity_ids) > 0 ? var.user_assigned_identity_ids : null
    }
  }

  # Conditional CMK encryption
  dynamic "encryption" {
    for_each = var.encryption == null ? [] : [var.encryption]
    content {
      key_vault_key_id    = encryption.value.key_vault_key_id
      identity_client_id  = encryption.value.identity_client_id
    }
  }

  tags = var.tags
}
