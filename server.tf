resource "azurerm_postgresql_server" "server" {
  location            = var.location
  name                = "${var.project}${var.stage}dbsrv${var.suffix}"
  resource_group_name = var.resource_group
  sku_name            = var.database_host_sku
  version             = var.database_version
  storage_mb          = var.database_storage

  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password

  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  auto_grow_enabled = var.autogrow
}
