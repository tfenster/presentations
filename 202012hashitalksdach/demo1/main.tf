terraform {
  backend "azurerm" {
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  version = ">= 2.37.0"
  features {}
}

variable "prefix" {
  description = "Prefix for all resources"
}

resource "azurerm_resource_group" "main" {
  location = "West Europe"
  name     = "${var.prefix}-demo1"
}

resource "azurerm_container_group" "aci" {
  name                = "${var.prefix}-aci"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  ip_address_type     = "public"
  dns_name_label      = "${var.prefix}-hello"
  os_type             = "linux"

  container {
    name   = "helloworld"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld"
    cpu    = 1
    memory = 1.5
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}

output "link" {
  value = "http://${azurerm_container_group.aci.fqdn}"
}
