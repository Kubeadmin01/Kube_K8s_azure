output "virtual_network_id" {
  description = "The ID of the VNet"
  value       = azurerm_virtual_network.vnet.id
}

output "aks_subnet_id" {
  description = "The ID of the AKS subnet"
  value       = azurerm_subnet.subnets["aks"].id
}

output "pesn_subnet_id" {
  description = "The ID of the private endpoint subnet"
  value       = azurerm_subnet.subnets["pesn"].id
}
