variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}

variable "location" {
    type = string
    description = "Azure region for the resources"
}

variable "vnet_name" {
  description = "Virtual Network name"
}

variable "subnet_name" {
  description = "Subnet name"
}

variable "tag_environment" {
  type    = string
}

variable "tag_owner" {
  type    = string
}