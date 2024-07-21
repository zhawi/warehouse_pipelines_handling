##
# Networking module
##

resource "azurerm_virtual_network" "devnet" {
    name = var.vnet_name
    address_space = [ "10.0.0.0/16" ]
    location = var.location
    resource_group_name = var.resource_group_name
    tags = {
        environment = var.tag_environment
        owner = var.tag_owner
    }
}

resource "azurerm_subnet" "devsubnet" {
    name = var.subnet_name
    address_prefixes = ["10.0.1.0/24"]
    resource_group_name = var.resource_group_name
    virtual_network_name = var.vnet_name
}