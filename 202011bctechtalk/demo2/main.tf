provider "azurerm" {
  version = ">= 2.36.0"
  features {}
}

provider "random" {
}

variable "prefix" {

}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-demo2"
  location = "West Europe"
}

resource "random_password" "password" {
  length           = 16
  min_lower        = 1
  min_numeric      = 1
  min_upper        = 1
  min_special      = 1
  special          = true
  override_special = "_%$"
}

output "password" {
  value = random_password.password.result
}

resource "azurerm_windows_virtual_machine" "vm" {
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  name                  = "${var.prefix}-vm"
  admin_username        = "VM-Administrator"
  admin_password        = random_password.password.result
  computer_name         = "demovm"
  size                  = "Standard_D2s_v4" # https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-general
  network_interface_ids = [azurerm_network_interface.vm.id]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

resource "azurerm_network_interface" "vm" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = "${var.prefix}-nic"

  ip_configuration {
    name                          = "IPconf"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.main.id
  }
}

resource "azurerm_subnet" "main" {
  resource_group_name  = azurerm_resource_group.main.name
  name                 = "${var.prefix}-subnet"
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_virtual_network" "main" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.3.0/24"]
}

resource "azurerm_network_security_group" "vm" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = "${var.prefix}-secgroup"
}

resource "azurerm_network_security_rule" "rdp" {
  name                        = "rdpIn"
  network_security_group_name = azurerm_network_security_group.vm.name
  resource_group_name         = azurerm_resource_group.main.name
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

resource "azurerm_network_interface_security_group_association" "vm" {
  network_interface_id      = azurerm_network_interface.vm.id
  network_security_group_id = azurerm_network_security_group.vm.id
}
