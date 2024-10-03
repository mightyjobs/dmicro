variable "prefix" {
  description = "A prefix used for all resources"
}

variable "location" {
  description = "The Azure Region in which all resources should be provisioned"
}

variable "resource_group_name" {
  description = "Name of the resource group to create"
}

variable "node_count" {
  description = "The number of nodes in the AKS cluster"
  default     = 1
}

variable "vm_size" {
  description = "The size of the Virtual Machine"
  default     = "Standard_B2s"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
