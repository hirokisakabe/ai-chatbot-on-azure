resource "azurerm_redis_cache" "redis" {
  name                = "ai-chatbot-on-azure-redis"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}
