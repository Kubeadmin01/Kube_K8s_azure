resource "azurerm_kubernetes_cluster" "K8s" {
  name                = var.k8s_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix != null ? var.dns_prefix : "${var.k8s_name}-dns"
  kubernetes_version  = var.kubernetes_version

  identity {
    type = "SystemAssigned"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = var.outbound_type
    service_cidr      = var.service_cidr
    dns_service_ip    = var.dns_service_ip != null ? var.dns_service_ip : cidrhost(var.service_cidr, 10)
  }

  default_node_pool {
    name            = "agentpool"
    vm_size         = var.node_vm_size
    os_disk_size_gb = var.os_disk_size_gb
    os_disk_type    = var.os_disk_type
    vnet_subnet_id  = var.subnet_id
    type            = "VirtualMachineScaleSets"

    auto_scaling_enabled = var.enable_auto_scaling
    node_count = var.enable_auto_scaling ? null : var.node_count_min
    min_count  = var.enable_auto_scaling ? var.node_count_min : null
    max_count  = var.enable_auto_scaling ? var.node_count_max : null

    max_pods = var.max_pods
    zones    = var.availability_zones
    os_sku   = "Ubuntu"

    
  }

  api_server_access_profile {
    authorized_ip_ranges = var.api_server_authorized_ip_ranges
  }

  tags = var.tags
}
