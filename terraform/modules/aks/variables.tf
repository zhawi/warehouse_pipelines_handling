variable "aks_name" {
  description = "Name for the resource"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Azure region for the resources"
}

variable "subnet_id" {
  description = "ID of the subnet"
}

variable "tag_environment" {
  type    = string
}

variable "tag_owner" {
  type    = string
}