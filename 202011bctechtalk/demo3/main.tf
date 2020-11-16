provider "azurerm" {
  version = ">= 2.36.0"
  features {}
}

provider "null" {
  version = "~> 3.0.0"
}

variable "prefix" {

}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-demo3"
  location = "West Europe"
}

resource "azurerm_function_app" "main" {
  name                       = "${var.prefix}-app"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  app_service_plan_id        = azurerm_app_service_plan.main.id
  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  version                    = "3"
  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "dotnet"
  }
}

resource "azurerm_app_service_plan" "main" {
  name                = "${var.prefix}-service-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_storage_account" "main" {
  name                     = "${var.prefix}storagedemo3"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "null_resource" "functions" {
  provisioner "local-exec" {
    command = "ping localhost -n 15 > NUL && cd function && func azure functionapp publish ${var.prefix}-app --force && cd .."
  }

  depends_on = [azurerm_function_app.main]
}
