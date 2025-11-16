variable "k8s_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix"
  default     = null
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "service_cidr" {
  type        = string
  description = "CIDR for Kubernetes services"
}

variable "dns_service_ip" {
  type        = string
  description = "DNS IP within service CIDR"
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "AKS subnet ID from Kubenet module"
}

variable "node_vm_size" {
  type        = string
  description = "VM size for AKS nodes"
}

variable "os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB"
}

variable "os_disk_type" {
  type        = string
  default     = "Managed"
}

variable "enable_auto_scaling" {
  type        = bool
  default     = true
}

variable "node_count_min" {
  type    = number
  default = 1
}

variable "node_count_max" {
  type    = number
  default = 3
}

variable "max_pods" {
  type    = number
  default = 30
}

variable "availability_zones" {
  type    = list(string)
  default = []
}



variable "outbound_type" {
  type    = string
  default = "loadBalancer"
}

variable "api_server_authorized_ip_ranges" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
<<<<<<< HEAD

variable "enable_agic" {
  type    = bool
  default = false
}

variable "appgw_id" {
  type        = string
  description = "Application Gateway id for AGIC"
  default     = ""
}
=======
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
