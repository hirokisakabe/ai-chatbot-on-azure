resource "azurerm_linux_web_app" "linux_web_app" {
  name                = "${var.project_name}-web-app"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  service_plan_id     = var.service_plan_id

  site_config {
    application_stack {
      docker_image_name        = var.docker_image_name
      docker_registry_url      = var.container_registry_url
      docker_registry_username = var.container_registry_admin_username
      docker_registry_password = var.container_registry_admin_password
    }
  }

  app_settings = {
    WEBSITES_PORT      = 3000
    NEXTAUTH_SECRET    = var.NEXTAUTH_SECRET
    NEXTAUTH_URL       = var.NEXTAUTH_URL
    AUTH_GITHUB_ID     = var.AUTH_GITHUB_ID
    AUTH_GITHUB_SECRET = var.AUTH_GITHUB_SECRET
    REDIS_HOST         = var.redis_host
    REDIS_PORT         = var.redis_port
    REDIS_PASSWORD     = var.redis_password
    OPENAI_API_KEY     = var.OPENAI_API_KEY
  }

  identity {
    type = "SystemAssigned"
  }
}
