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

<<<<<<< HEAD
  subnet_id    = module.Kubenet.k8s_subnet_id
  service_cidr = var.service_cidr
  tags         = var.tags

  appgw_id            = module.Application_gateway.appgw_id
}

# --- DATA SOURCES FOR AGIC ROLE ASSIGNMENTS ---

// The existing appgw_assign is fine, keeping it for context
resource "azurerm_role_assignment" "appgw_assign" {
  scope                = module.Application_gateway.appgw_id
  role_definition_name = "Contributor"
  principal_id         = module.K8s.k8s_identity_principal_id

  # optional: explicit dependency to avoid timing issues
  depends_on = [
    module.Application_gateway,
    module.K8s
  ]
}

# Corrected Role Assignment 1: Contributor on Application Gateway
resource "azurerm_role_assignment" "agic_appgw_contributor" {
  # Fix: Use the ID output from the Application Gateway module
  scope                = module.Application_gateway.appgw_id 
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_user_assigned_identity.agic_identity.principal_id

  depends_on = [
    module.Application_gateway
  ]
}

# Corrected Role Assignment 2: Network Contributor on App Gateway Subnet
resource "azurerm_role_assignment" "agic_subnet_network_contributor" {
  # Fix: Use the ID of the locally created Subnet resource, likely keyed "agw"
  scope                = module.Kubenet.appgw_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = data.azurerm_user_assigned_identity.agic_identity.principal_id
  depends_on = [
    module.Kubenet
  ]
}

# Corrected Role Assignment 3: Reader on Application Gateway Resource Group
resource "azurerm_role_assignment" "agic_rg_reader" {
  # Fix: Use the ID of the locally created Resource Group
  scope                = azurerm_resource_group.RG.id 
  role_definition_name = "Reader"
  principal_id         = data.azurerm_user_assigned_identity.agic_identity.principal_id
}


# 4. The AKS Managed Resource Group (where the AGIC identity is created)
data "azurerm_resource_group" "k8s_managed_rg" {
  # Naming convention: MC_<AKS_RG_Name>_<AKS_Cluster_Name>
  name = "MC_${azurerm_resource_group.RG.name}_${var.k8s_name}_${var.location}"
  depends_on = [
    module.K8s
  ]
}

# 5. The AGIC Managed Identity (Principal for all roles)
data "azurerm_user_assigned_identity" "agic_identity" {
  name                = "ingressapplicationgateway-${var.k8s_name}"
  resource_group_name = data.azurerm_resource_group.k8s_managed_rg.name

  # Dependency is crucial: the cluster must be created first for the identity to exist
  depends_on = [
    module.K8s
  ]
}

# --- END DATA SOURCES ---



# -------------------------------------------------------------
# APPLICATION GATEWAY Module
# -------------------------------------------------------------
module "Application_gateway" {
  source                          = "./modules/Application_gateway"
  resource_group_name             = azurerm_resource_group.RG.name
  location                        = var.location
  azurerm_application_gateway_name = var.azurerm_application_gateway_name
  azurerm_public_ip_name           = var.azurerm_public_ip_name
  appgw_ip_configuration_name      = var.appgw_ip_configuration_name
  tags                            = var.tags
  private_ip_address              = var.private_ip_address

  appgw_subnet_id                 = module.Kubenet.appgw_subnet_id
=======
  subnet_id    = module.Kubenet.aks_subnet_id
  service_cidr = var.service_cidr
  tags         = var.tags
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
}







<<<<<<< HEAD
=======

>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
