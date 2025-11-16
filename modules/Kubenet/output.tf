output "virtual_network_id" {
  description = "The ID of the VNet"
  value       = azurerm_virtual_network.vnet.id
}

<<<<<<< HEAD
output "k8s_subnet_id" {
  description = "The ID of the AKS subnet"
  value       = azurerm_subnet.subnets["k8s"].id
=======
output "aks_subnet_id" {
  description = "The ID of the AKS subnet"
  value       = azurerm_subnet.subnets["aks"].id
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
}

output "pesn_subnet_id" {
  description = "The ID of the private endpoint subnet"
  value       = azurerm_subnet.subnets["pesn"].id
}
<<<<<<< HEAD
output "appgw_subnet_id" {
  description = "The ID of the application gateway subnet"
  value       = azurerm_subnet.subnets["agw"].id
}
=======
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
