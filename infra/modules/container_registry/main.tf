resource "azurerm_container_registry" "acr" {
  name                = "aichatbotonazureregistry"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Standard"
  admin_enabled       = true
}
