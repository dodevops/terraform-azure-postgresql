resource "azurerm_postgresql_server" "server" {
  location                     = var.location
  name                         = "${var.project}${var.stage}dbsrv${var.suffix}"
  resource_group_name          = var.resource_group
  sku_name                     = var.database_host_sku
  version                      = var.database_version
  storage_mb                   = var.database_storage
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  auto_grow_enabled            = var.autogrow

  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}