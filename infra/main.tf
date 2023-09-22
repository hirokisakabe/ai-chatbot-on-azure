resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

resource "azurerm_service_plan" "service_plan" {
  name                = "ai-chatbot-on-azure-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "linux_web_app" {
  name                = "ai-chatbot-on-azure-web-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.service_plan.location
  service_plan_id     = azurerm_service_plan.service_plan.id

  site_config {
    application_stack {
      docker_image_name = "samples/ai-chatbot-on-azure:latest"
      docker_registry_url = "https://aichatbotonazureregistry.azurecr.io"
      docker_registry_username =  azurerm_container_registry.acr.admin_username
      docker_registry_password = azurerm_container_registry.acr.admin_password
    }
  }
  app_settings = {
    WEBSITES_PORT = 3000
    DOCKER_REGISTRY_SERVER_URL = "https://aichatbotonazureregistry.azurecr.io"
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.acr.admin_password
    NEXTAUTH_SECRET = var.AUTH_SECRET
    NEXTAUTH_URL = var.NEXTAUTH_URL
    AUTH_GITHUB_ID = var.AUTH_GITHUB_ID
    AUTH_GITHUB_SECRET = var.AUTH_GITHUB_SECRET
    REDIS_HOST=azurerm_redis_cache.redis.hostname
    REDIS_PORT=azurerm_redis_cache.redis.port
    REDIS_PASSWORD=azurerm_redis_cache.redis.primary_access_key
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "aichatbotonazureregistry"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = true
}

variable "AUTH_SECRET" {
  type    = string
  default = null
}
variable "AUTH_GITHUB_ID" {
  type    = string
  default = null
}
variable "AUTH_GITHUB_SECRET" {
  type    = string
  default = null
}
variable "NEXTAUTH_URL" {
  type    = string
  default = null
}

resource "azurerm_redis_cache" "redis" {
  name                = "ai-chatbot-on-azure-redis"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = true
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}
