

# VNet
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
  tags                = var.tags
}

# Subnets for AKS & Private Endpoint
resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.cidr]
  service_endpoints    = each.value.service_endpoints
}

# NSG for each subnet
resource "azurerm_network_security_group" "pesn_nsg" {
  name                = "${azurerm_subnet.subnets["pesn"].name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "aks_nsg" {
  name                = "${azurerm_subnet.subnets["aks"].name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# NSG Associations
resource "azurerm_subnet_network_security_group_association" "pesn_nsg_association" {
  subnet_id                 = azurerm_subnet.subnets["pesn"].id
  network_security_group_id = azurerm_network_security_group.pesn_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "aks_nsg_association" {
  subnet_id                 = azurerm_subnet.subnets["aks"].id
  network_security_group_id = azurerm_network_security_group.aks_nsg.id
}

# NSG Rules for AKS
resource "azurerm_network_security_rule" "aks_nsg_rule_inbound" {
  for_each                    = local.aks_inbound_ports_map
  name                        = "aks-rule-inbound-${each.key}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}

resource "azurerm_network_security_rule" "aks_nsg_rule_outbound" {
  for_each                    = local.aks_inbound_ports_map
  name                        = "aks-rule-outbound-${each.key}"
  priority                    = each.key
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}

# NSG Rules for PESN
resource "azurerm_network_security_rule" "pesn_nsg_rule_inbound" {
  for_each                    = local.pesn_inbound_ports_map
  name                        = "pesn-rule-inbound-${each.key}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.pesn_nsg.name
}

resource "azurerm_network_security_rule" "pesn_nsg_rule_outbound" {
  for_each                    = local.pesn_inbound_ports_map
  name                        = "pesn-rule-outbound-${each.key}"
  priority                    = each.key
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.pesn_nsg.name
}

# Validation
resource "random_id" "validate" {
  byte_length = 2
  lifecycle {
    precondition {
      condition     = !can(cidrnetmask(var.service_cidr)) ? false : true
      error_message = "service_cidr must be a valid CIDR."
    }
    precondition {
      condition = alltrue([
        for s in values(var.subnets) : cidrhost(s.cidr, 1) != cidrhost(var.service_cidr, 1)
      ])
      error_message = "service_cidr must NOT overlap any subnet CIDR."
    }
  }
}
