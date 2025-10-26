locals {
  tags = merge({
    "module" = "aks"
  }, var.tags)
}