provider "azurerm" {
  version = ">= 2.37.0"
  features {}
}

data "azurerm_client_config" "current" {}

variable "prefix" {}

resource "azurerm_resource_group" "main" {
  location = "West Europe"
  name     = "${var.prefix}-demo0"
}

resource "azurerm_storage_account" "main" {
  name                     = "${var.prefix}statestore"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "statecontainer-demo1" {
  name                  = "statecontainer-demo1"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "statecontainer-demo2" {
  name                  = "statecontainer-demo2"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "statecontainer-demo3" {
  name                  = "statecontainer-demo3"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_key_vault" "main" {
  name                        = "${var.prefix}-vault"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_deployment      = true
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = true
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
      "create"
    ]

    secret_permissions = [
      "get",
      "set",
      "list",
      "delete"
    ]

    certificate_permissions = [
      "get",
      "create"
    ]
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}

resource "azurerm_key_vault_secret" "statestore-key" {
  name         = "statestore-key"
  value        = azurerm_storage_account.main.primary_access_key
  key_vault_id = azurerm_key_vault.main.id
}
