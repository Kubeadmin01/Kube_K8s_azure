# Resource Group (created if requested)
resource "azurerm_resource_group" "RG" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# -------------------------------------------------------------
# Network Module
# -------------------------------------------------------------
module "Kubenet" {
  source              = "./modules/Kubenet"
  resource_group_name = azurerm_resource_group.RG.name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  service_cidr        = var.service_cidr
  subnets             = var.subnets
}




# -------------------------------------------------------------
# Storage Account Module
# -------------------------------------------------------------
module "Storageaccount" {
  source                  = "./modules/Storageaccount"
  resource_group_name     = azurerm_resource_group.RG.name
  resource_group_location = azurerm_resource_group.RG.location
  azurerm_subnet_id       = module.Kubenet.pesn_subnet_id # ✅ fixed reference
  random_prefix           = var.random_prefix
}

# -------------------------------------------------------------
# Key Vault Module
# -------------------------------------------------------------
module "Keyvault" {
  source                  = "./modules/Keyvault"
  resource_group_name     = azurerm_resource_group.RG.name
  resource_group_location = azurerm_resource_group.RG.location
  azurerm_subnet_id       = module.Kubenet.pesn_subnet_id # ✅ fixed reference
  random_prefix           = var.random_prefix
}

# -------------------------------------------------------------
# Container Registry Module
# -------------------------------------------------------------
module "ACR" {
  source              = "./modules/ACR"
  resource_group_name = azurerm_resource_group.RG.name
  acr_name            = var.acr_name
  location            = var.location
  random_prefix       = var.random_prefix
  tags                = var.tags
}

# -------------------------------------------------------------
# AKS Module
# -------------------------------------------------------------
module "K8s" {
  source              = "./modules/K8s"
  k8s_name            = var.k8s_name
  location            = var.location
  resource_group_name = azurerm_resource_group.RG.name
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = var.dns_prefix

  node_vm_size        = var.node_vm_size
  os_disk_size_gb     = var.os_disk_size_gb
  os_disk_type        = var.os_disk_type
  enable_auto_scaling = var.enable_auto_scaling
  node_count_min      = var.node_count_min
  node_count_max      = var.node_count_max
  max_pods            = var.max_pods
  availability_zones  = var.availability_zones

  subnet_id    = module.Kubenet.aks_subnet_id
  service_cidr = var.service_cidr
  tags         = var.tags
}








