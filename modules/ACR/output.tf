output "id" {
description = "Resource ID of the ACR."
value = azurerm_container_registry.acr.id
}


output "name" {
description = "Name of the ACR."
value = azurerm_container_registry.acr.name
}


output "login_server" {
description = "The login server (e.g., myacr.azurecr.io)."
value = azurerm_container_registry.acr.login_server
}


output "admin_username" {
description = "Admin username (only if admin_enabled)."
value = azurerm_container_registry.acr.admin_username
sensitive = true
}