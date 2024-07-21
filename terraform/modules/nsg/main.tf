##
# network security group module
##

resource "azurerm_network_security_group" "devnsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allowed_ip
    destination_address_prefix = "*"
  }

  tags = {
        environment = var.tag_environment
        owner = var.tag_owner
    }
}

resource "azurerm_subnet_network_security_group_association" "subnetnsg" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.devnsg.id
}
