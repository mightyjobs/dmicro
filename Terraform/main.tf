provider "azurerm" {
  features {}
}

module "aks" {
  source              = "./modules/aks"
  prefix              = "myaks"
  location            = "East US"
  resource_group_name = "my-aks-rg"
  node_count          = 2
  vm_size             = "Standard_B2s"
  tags = {
    Environment = "Development"
  }
}

output "cluster_name" {
  value = module.aks.cluster_name
}

output "resource_group_name" {
  value = module.aks.resource_group_name
}

output "kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}
