

# Application Gateway using Kubenet subnet and K8s backend
resource "azurerm_public_ip" "appgw_pip" {
  name                = var.azurerm_public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}



resource "azurerm_application_gateway" "appgw" {
  name                = var.azurerm_application_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = var.appgw_ip_configuration_name
    subnet_id = var.appgw_subnet_id
  }

  # --- ADD THIS BLOCK FOR PRIVATE FRONTEND IP ---
  frontend_ip_configuration {
    name                              = local.private_frontend_ip_configuration_name # e.g., "frontend-private-ip"
    # This must reference the same subnet as the gateway_ip_configuration
    subnet_id                         = var.appgw_subnet_id 
    # Choose dynamic or static allocation
    private_ip_address_allocation     = "Static" # or "Dynamic"
    private_ip_address              = var.private_ip_address 
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    }
 
# If using an integrated WAF configuration (not recommended for production):
  # firewall_policy_id = null
  waf_configuration {
    enabled            = true
    firewall_mode      = "Detection" # or "Prevention"
    rule_set_type      = "OWASP"
    rule_set_version   = "3.2"        # or "3.1"
  }

  # OR (Recommended) if using an external WAF Policy:
  # firewall_policy_id = azurerm_application_gateway_waf_policy.example.id
}