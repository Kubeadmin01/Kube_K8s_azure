
variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where the registry will live."
  type        = string
}

variable "location" {
  description = "Azure region for the registry."
  type        = string
}

variable "sku" {
  description = "ACR SKU: Basic, Standard, or Premium."
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "sku must be one of: Basic, Standard, Premium"
  }
}

variable "admin_enabled" {
  description = "Enable the admin user on the registry (not recommended for production)."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether the registry's public network access is enabled."
  type        = bool
  default     = true
}

variable "network_ip_rules" {
  description = "List of CIDR blocks permitted to access when network rules are enabled (implies default deny)."
  type        = list(string)
  default     = []
}

variable "anonymous_pull_enabled" {
  description = "Allow anonymous pulls."
  type        = bool
  default     = false
}

variable "data_endpoint_enabled" {
  description = "Enable dedicated data endpoint (Premium only)."
  type        = bool
  default     = false
}

variable "export_policy_enabled" {
  description = "Enable export operations over public network."
  type        = bool
  default     = true
}

variable "zone_redundancy" {
  description = "Zone redundancy for the registry (Disabled or Enabled – depends on region/SKU)."
  type        = string
  default     = "Disabled"
  validation {
    condition     = contains(["Disabled", "Enabled"], var.zone_redundancy)
    error_message = "zone_redundancy must be Disabled or Enabled"
  }
}

variable "georeplications" {
  description = "Optional list of geo-replication settings (Premium only)."
  type = list(object({
    location                   = string
    regional_endpoint_enabled  = optional(bool)
    zone_redundancy            = optional(string)
    tags                       = optional(map(string))
  }))
  default = []
}

variable "enable_identity" {
  description = "Whether to attach a managed identity (required for CMK)."
  type        = bool
  default     = true
}

variable "user_assigned_identity_ids" {
  description = "Optional list of User Assigned Managed Identity (UAMI) IDs to attach. If empty and enable_identity is true, a System Assigned identity is used."
  type        = list(string)
  default     = []
}

variable "encryption" {
  description = "Customer-managed key configuration. When set, provides CMK encryption using a Key Vault key. identity_client_id must match an attached identity."
  type = object({
    key_vault_key_id  = string
    identity_client_id = string
  })
  default = null
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
variable "random_prefix" {
  description = "A random prefix for resource naming"
  type        = string
}
