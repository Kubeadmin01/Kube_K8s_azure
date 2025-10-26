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