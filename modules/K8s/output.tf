output "cluster_id" {
  value = azurerm_kubernetes_cluster.K8s.id
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.K8s.kubelet_identity[0].object_id
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.K8s.kube_config_raw
  sensitive = true
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.K8s.node_resource_group
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.K8s.name
}

output "subnet_id" {
  value = var.subnet_id
}
