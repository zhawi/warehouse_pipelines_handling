variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Azure region for the resources"
}

variable "subnet_id" {
  description = "ID of the subnet"
}

variable "nsg_name" {
  description = "name of nsg resource group"
}

variable "allowed_ip" {
  description = "IP address allowed to SSH"
}

variable "tag_environment" {
  type    = string
}

variable "tag_owner" {
  type    = string
}