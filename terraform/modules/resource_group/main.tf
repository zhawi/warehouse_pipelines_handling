##
# resource group module
##

resource "azurerm_resource_group" "devrg" {
    name     = var.resource_group_name
    location = var.location
    tags = {
        environment = var.tag_environment
        owner = var.tag_owner
    }
}