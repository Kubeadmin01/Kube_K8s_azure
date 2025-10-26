```

---

## README.md

````md
# AKS Terraform Module (Production-Ready Defaults)

This module deploys an **Azure Kubernetes Service (AKS)** cluster with a dedicated **Virtual Network** and **Subnet**, Ubuntu-based Linux nodes, and sensible production defaults.

## Features
- Dedicated **VNet** and **Subnet** for the AKS cluster
- **Azure CNI (native)** networking with Standard LB
- **Ubuntu** node image (Linux)
- Default node size set to **`Standard_B2s`** (a low-cost SKU); override as needed
- **Managed Identity**, **OIDC issuer** and **Workload Identity** enabled
- **RBAC enabled**
- Optional **autoscaling** and **availability zones**
- Validations to ensure `service_cidr` does **not** overlap with VNet/Subnet
- Outputs for downstream consumption

## Quick Start
```hcl
module "aks" {
  source = "../modules/aks"

  name                = "prod-aks"
  location            = "eastus"
  resource_group_name = "rg-prod-aks"

  vnet_name          = "vnet-prod-aks"
  vnet_address_space = ["10.240.0.0/16"]
  subnet_name        = "snet-aks-nodes"
  subnet_cidr        = "10.240.0.0/22"

  service_cidr       = "10.0.0.0/16" # must NOT overlap VNet/Subnet

  node_vm_size       = "Standard_B2s"
}
````

## Notes

* `service_cidr` must **not** overlap with VNet/Subnet.
* With **Azure CNI**, pods consume addresses from the subnet; size your subnet accordingly (max pods per node × node count).
* Add diagnostics/monitoring modules as per your org standards (e.g., AMA/Container Insights, diagnostic settings).

```
```
