output "cluster_id" {
<<<<<<< HEAD
  value = azurerm_kubernetes_cluster.k8s.id
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config_raw
=======
  value = azurerm_kubernetes_cluster.K8s.id
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.K8s.kubelet_identity[0].object_id
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.K8s.kube_config_raw
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
  sensitive = true
}

output "node_resource_group" {
<<<<<<< HEAD
  value = azurerm_kubernetes_cluster.k8s.node_resource_group
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
=======
  value = azurerm_kubernetes_cluster.K8s.node_resource_group
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.K8s.name
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
}

output "subnet_id" {
  value = var.subnet_id
}
<<<<<<< HEAD

output "k8s_identity_principal_id" {
  description = "k8s cluster system assigned identity principal id"
  value       = azurerm_kubernetes_cluster.k8s.identity[0].principal_id
  sensitive   = true
}
=======
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
