resource "azurerm_service_plan" "service_plan" {
  name                = "${var.project_name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  os_type             = "Linux"
  sku_name            = "P1v2"
}
