##
# Variables
##

variable "location" {
    type = string
    default = "west europe"
}

variable "naming_prefix" {
  type    = string
  default = "development"
}

variable "tag_environment" {
  type    = string
  default = "dev"
}

variable "tag_owner" {
  type    = string
  default = "pedro"
}

variable "my_ip_address" {
  description = "IP address allowed to SSH"
}

variable "default_action" {
  description = "Default action for storage account network rules"
  default     = "Deny"
}
