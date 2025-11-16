variable "azurerm_subnet_id" {
  type        = string
  description = "The ID of the subnet for the private endpoint"
}

variable "random_prefix" {
  type        = string
  description = "Random prefix for naming"
}
variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}

variable "node_count_min" {
  description = "Minimum node count for auto-scaling."
  type        = number
  default     = 1
}

variable "node_count_max" {
  description = "Maximum node count for auto-scaling."
  type        = number
  default     = 3
}

variable "enable_auto_scaling" {
  description = "Enable AKS cluster auto-scaling."
  type        = bool
  default     = false
}
