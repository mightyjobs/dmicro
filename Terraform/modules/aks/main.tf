# Remove this part
# resource "azurerm_resource_group" "aks" {
#   name     = var.resource_group_name
#   location = var.location
# }

# Virtual network and other resources
resource "azurerm_virtual_network" "aks" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.2.0.0/16"]
  location            = var.location                # Use the passed-in variable for location
  resource_group_name = var.resource_group_name      # Use the passed-in variable for resource group name
}

resource "azurerm_subnet" "aks" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = var.resource_group_name     # Use the passed-in variable
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = var.location                # Use the passed-in variable
  resource_group_name = var.resource_group_name      # Use the passed-in variable
  dns_prefix          = "${var.prefix}-aks"

  default_node_pool {
    name           = "default"
    node_count     = var.node_count
    vm_size        = var.vm_size
    vnet_subnet_id = azurerm_subnet.aks.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = "10.2.2.0/24"
    dns_service_ip    = "10.2.2.10"
  }

  tags = var.tags
}
