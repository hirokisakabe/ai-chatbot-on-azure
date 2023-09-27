resource "azurerm_container_registry" "acr" {
  name                = "${replace(var.project_name, "-", "")}registry"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Standard"
  admin_enabled       = true
}
