##
# Storage account module
##

resource "azurerm_storage_account" "main" {
  name                     = var.storage_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    virtual_network_subnet_ids = [var.subnet_id]
    default_action = var.default_action
  }

  tags = {
        environment = var.tag_environment
        owner = var.tag_owner
    }
}