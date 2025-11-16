acr_name            = "kubeprodacr01"       #Azure Container Registry name
resource_group_name = "kubeprod-rg"         #Resource Group name   
k8s_name            = "kubeprod-k8s"        #Kubernetes cluster name
vnet_name           = "kubeprod-vnet"       #Virtual Network name
random_prefix       = "kubeprod"            #Random prefix for resource naming
subnet_name         = "kubeprod-aks-subnet" #Subnet name for AKS nodes/pods
<<<<<<< HEAD
azurerm_application_gateway_name = "kubeprod-agw" #Application Gateway name
azurerm_public_ip_name        = "kubeprod-agw-pip" #Public IP name for Application Gateway
appgw_ip_configuration_name = "kubeprod-agw-ip-config" #Application Gateway IP configuration name
private_ip_address           = "10.2.0.38" # Private IP address for Application Gateway


location = "WestEurope" #Resource Group location
subnets = {
  k8s = {
=======


location = "West Europe" #Resource Group location
subnets = {
  aks = {
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
    cidr              = "10.1.0.0/25"
    service_endpoints = ["Microsoft.ContainerRegistry", "Microsoft.Storage", "Microsoft.KeyVault"]
  }
  pesn = {
    cidr              = "10.2.0.0/27"
    service_endpoints = []
  }
<<<<<<< HEAD
  agw = {
    cidr              = "10.2.0.32/27"
    service_endpoints = []
  }
=======
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
}

vnet_address_space = ["10.0.0.0/8"] #Virtual Network address space

service_cidr        = "10.3.0.0/25"     #CIDR for Kubernetes services
dns_prefix          = "kubek8s"         #DNS prefix for AKS cluster
node_vm_size        = "Standard_DS2_v2" #VM size for AKS nodes
node_count_min      = 1
node_count_max      = 3
enable_auto_scaling = true
os_disk_size_gb     = 128
os_disk_type        = "Managed"
availability_zones  = ["1", "2", "3"]
tags                = { env = "stag" }
