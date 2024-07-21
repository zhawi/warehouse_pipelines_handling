variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Azure region for the resources"
}

variable "subnet_id" {
  description = "ID of the subnet"
}

variable "storage_name" {
  description = "name for the storage account"
}

variable "default_action" {
  description = "Default action for network rules (Allow or Deny)"
  default     = "Deny"
}

variable "tag_environment" {
  type    = string
}

variable "tag_owner" {
  type    = string
}