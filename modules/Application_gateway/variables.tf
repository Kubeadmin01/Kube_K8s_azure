variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "azurerm_application_gateway_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "azurerm_public_ip_name" {
  type        = string
  description = "Name of the Public IP for Application Gateway"
}

variable "appgw_subnet_id" {
  type        = string
  description = "Subnet ID for Application Gateway from Kubenet module"
}

variable "appgw_ip_configuration_name" {
  type        = string
  description = "Name for IP configuration"
}



variable "tags" {
  type    = map(string)
  default = {}
}

variable "private_ip_address" {
  type = string
  description = "private frontend ip address of the application gateway"
}

