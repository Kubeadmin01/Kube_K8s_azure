<<<<<<< HEAD
resource "azurerm_kubernetes_cluster" "k8s" {
=======
resource "azurerm_kubernetes_cluster" "K8s" {
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
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

<<<<<<< HEAD
# --- AGIC ADD-ON CONFIGURATION ---
  ingress_application_gateway {
    gateway_id = var.appgw_id
  }
  # --- END AGIC CONFIGURATION ---

=======
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
  api_server_access_profile {
    authorized_ip_ranges = var.api_server_authorized_ip_ranges
  }

  tags = var.tags
}
<<<<<<< HEAD

###DATA BLOCK TO GET AKS MANAGED RESOURCE GROUP###

data "azurerm_resource_group" "k8s_managed_rg" {
  # Note: The 'MC_' group will not exist until the AKS cluster is provisioned.
  # This data block relies on the naming convention.
  name = "MC_${var.resource_group_name}_${var.k8s_name}_${var.location}"
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}



###K8s MANAGED IDENTITY FOR AGIC###
data "azurerm_user_assigned_identity" "agic_identity" {
  name                = "ingressapplicationgateway-${var.k8s_name}"
  resource_group_name = data.azurerm_resource_group.k8s_managed_rg.name
  # Ensure this block runs after the cluster is created and the identity exists
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

# The principal ID of the AGIC identity is accessed via:
# data.azurerm_user_assigned_identity.agic_identity.principal_id
=======
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
