variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created."
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "vnet_address_space" {
  description = "Address space of the virtual network."
  type        = list(string)

  validation {
    condition     = length(var.vnet_address_space) > 0
    error_message = "At least one VNet address space must be specified."
  }
}

variable "subnets" {
  description = "Map of subnet configurations."
  type = map(object({
    cidr              = string
    service_endpoints = list(string)
  }))
}

variable "service_cidr" {
  description = "CIDR for Kubernetes services (must NOT overlap with VNet/Subnet)."
  type        = string

  validation {
    condition     = can(cidrhost(var.service_cidr, 1))
    error_message = "service_cidr must be a valid CIDR."
  }
}

variable "dns_service_ip" {
  description = "IP address within service_cidr for kube-dns (defaults to +10)."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}
