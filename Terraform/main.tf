# Provider for Azure Resource Manager
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Provider for Helm (Kubernetes)
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "azurerm_resource_group" "my_aks_rg" {
  name     = "my-aks-rg"
  location = "East US"
}
module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.my_aks_rg.name  # Pass the resource group from outside
  location            = azurerm_resource_group.my_aks_rg.location
  prefix              = "dnmicroaks"
  node_count          = 3
  vm_size             = "Standard_DS2_v2"
  tags                = { environment = "dev" }
}

# Variable for Subscription ID
variable "subscription_id" {
  description = "The Subscription ID which should be used"
  type        = string
}

# Flagger Module for deploying Flagger, NGINX, and Prometheus Helm charts
# module "flagger" {
#   source   = "./modules/flagger"
#   aks_ready = true  # Signal that AKS is ready
#   depends_on = [ module.aks ]
# }


# Outputs for AKS module
output "cluster_name" {
  value = module.aks.cluster_name
}

output "resource_group_name" {
  value = module.aks.resource_group_name
}

# output "kube_config" {
#   value     = module.aks.kube_config
#   sensitive = true
# }