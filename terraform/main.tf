##
# Main terraform
##


#resource to generate a number integer do add to 
resource "random_integer" "name_suffix" {
  min = 10000
  max = 99999
}

#local variables just to be used on this main.tf
locals {
  resource_group_name = "${var.tag_owner}-${var.naming_prefix}-${random_integer.name_suffix.result}-rg"
  vnet_name = "${var.naming_prefix}-${random_integer.name_suffix.result}-vnet"
  subnet_name = "${var.naming_prefix}-${random_integer.name_suffix.result}-subnet"
  storage_name = "${var.naming_prefix}-${random_integer.name_suffix.result}-sg"
  nsg_name = "${var.naming_prefix}-${random_integer.name_suffix.result}-nsg"
  aks_name = "${var.naming_prefix}-${random_integer.name_suffix.result}-aks"

}

module "resource_group" {
  source          = "./modules/resource_group"
  location        = var.location
  resource_group_name = local.resource_group_name
  tag_environment = var.tag_environment
  tag_owner       = var.tag_owner
}

module "virtual_network" {
  source              = "./modules/network"
  resource_group_name = local.resource_group_name
  location            = var.location
  vnet_name           = local.vnet_name
  subnet_name         = local.subnet_name
  tag_environment     = var.tag_environment
  tag_owner           = var.tag_owner
}

module "nsg" {
  source = "./modules/nsg"
  nsg_name = local.nsg_name
  resource_group_name = local.resource_group_name
  location            = var.location
  subnet_id         = module.virtual_network.subnet_id
  tag_environment     = var.tag_environment
  tag_owner           = var.tag_owner
  allowed_ip = var.my_ip_address
  
}

module "storage" {
  source             = "./modules/storage"
  storage_name = local.storage_name
  resource_group_name = local.resource_group_name
  location            = var.location
  subnet_id = module.virtual_network.subnet_id
  tag_environment = var.tag_environment
  tag_owner = var.tag_owner
  default_action = var.default_action
}

module "aks" {
  source = "./modules/aks"
  aks_name = local.aks_name
  resource_group_name = local.resource_group_name
  tag_environment = var.tag_environment
  tag_owner = var.tag_owner
  location = var.location
  subnet_id = module.virtual_network.subnet_id
}
