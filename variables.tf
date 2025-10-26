variable "resource_group_name" {
  description = "Resource group name where the registry will live."
  type        = string

}



##AKS variables

variable "k8s_name" {
  description = "AKS cluster name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}




variable "dns_prefix" {
  description = "DNS prefix for the API server"
  type        = string
  default     = null
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version (e.g. 1.29.x)"
  type        = string
  default     = null
}





variable "outbound_type" {
  description = "AKS outbound type: loadBalancer or userDefinedRouting"
  type        = string
  default     = "loadBalancer"
  validation {
    condition     = contains(["loadBalancer", "userDefinedRouting"], var.outbound_type)
    error_message = "outbound_type must be loadBalancer or userDefinedRouting"
  }
}




variable "service_cidr" {
  description = "The CIDR to use for Kubernetes services."
  type        = string
}




# other variable definitions...
# Node pool
variable "node_vm_size" {
  description = "VM size for nodes (default low-cost Standard_B2s)"
  type        = string
  default     = "Standard_B2s"
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB"
  type        = number
  default     = 128
}

variable "os_disk_type" {
  description = "OS disk type"
  type        = string
  default     = "Managed"
}

variable "enable_auto_scaling" {
  description = "Enable node autoscaling"
  type        = bool
  default     = true
}

variable "node_count_min" {
  description = "Minimum node count (or fixed count if autoscaling disabled)"
  type        = number
  default     = 1
}

variable "node_count_max" {
  description = "Maximum node count (when autoscaling enabled)"
  type        = number
  default     = 3
}

variable "max_pods" {
  description = "Max pods per node (affects IP consumption)"
  type        = number
  default     = 30
}

variable "availability_zones" {
  description = "Availability zones for the default node pool"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "max_surge" {
  description = "The max surge setting for upgrades (e.g., 33%)"
  type        = string
  default     = "33%"
}

variable "api_server_authorized_ip_ranges" {
  description = "List of authorized IP ranges for API server"
  type        = list(string)
  default     = []
}



##ACR variables

variable "random_prefix" {
  description = "Random prefix for resource naming"
  type        = string
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}





# Add your variable declarations below



# Networking
variable "subnets" {
  description = "Map of subnet names to subnet address prefixes."
  type = map(object({
    cidr              = string
    service_endpoints = list(string)
  }))
}


variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

variable "vnet_address_space" {
  description = "Virtual Network address space list"
  type        = list(string)
}

variable "subnet_name" {
  description = "Subnet name for AKS nodes/pods"
  type        = string
}



variable "subnet_service_endpoints" {
  description = "List of service endpoints on the subnet"
  type        = list(string)
  default     = ["Microsoft.ContainerRegistry", "Microsoft.Storage"]
}



variable "dns_service_ip" {
  description = "IP address within service_cidr for kube-dns (defaults to +10)"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags to apply to the resources."
  type        = map(string)
  default     = {}
}
# Add your variable declarations below





# other variable declarations