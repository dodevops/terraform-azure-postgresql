# tfsec is confused by the count default, so it raises the following false positives, which are set below. Hence the ignores.
#tfsec:ignore:azure-database-postgres-configuration-log-connections tfsec:ignore:azure-database-postgres-configuration-connection-throttling tfsec:ignore:azure-database-postgres-configuration-log-checkpoints
resource "azurerm_postgresql_server" "server" {
  count                         = var.database_flexible ? 0 : 1
  location                      = var.location
  name                          = "${var.project}${var.stage}dbsrv${var.suffix}"
  resource_group_name           = var.resource_group
  sku_name                      = var.database_host_sku
  version                       = var.database_version
  storage_mb                    = var.database_storage
  backup_retention_days         = var.backup_retention_days
  geo_redundant_backup_enabled  = var.geo_redundant_backup_enabled
  administrator_login           = var.admin_login
  administrator_login_password  = var.admin_password
  auto_grow_enabled             = var.autogrow
  public_network_access_enabled = var.public_access

  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_flexible_server" "server" {
  count                  = var.database_flexible ? 1 : 0
  location               = var.location
  name                   = "${var.project}${var.stage}dbsrv${var.suffix}"
  resource_group_name    = var.resource_group
  version                = var.database_version
  administrator_login    = var.admin_login
  administrator_password = var.admin_password
  sku_name               = var.database_host_sku
  storage_mb             = var.database_storage
  backup_retention_days  = var.backup_retention_days
  zone                   = var.availability_zone
}

locals {
  server_fqdn = var.database_flexible ? azurerm_postgresql_flexible_server.server.0.fqdn : azurerm_postgresql_server.server.0.fqdn
  server_name = var.database_flexible ? azurerm_postgresql_flexible_server.server.0.name : azurerm_postgresql_server.server.0.name
}

resource "azurerm_postgresql_configuration" "log-connections-normal" {
  count               = var.database_flexible ? 0 : 1
  name                = "log_connections"
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_server.server.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "log-connections-flexible" {
  count               = var.database_flexible ? 1 : 0
  name                = "log_connections"
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_flexible_server.server.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "connection-throttling-normal" {
  count               = var.database_flexible ? 0 : 1
  name                = "connection_throttling"
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_server.server.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "connection-throttling-flexible" {
  count               = var.database_flexible ? 1 : 0
  name                = "connection_throttling"
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_flexible_server.server.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "log-checkpoints-normal" {
  count               = var.database_flexible ? 0 : 1
  name                = "log_checkpoints"
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_server.server.name
  value               = "on"
}

resource "azurerm_postgresql_configuration" "log-checkpoints-flexible" {
  count               = var.database_flexible ? 1 : 0
  name                = "log_checkpoints"
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_flexible_server.server.name
  value               = "on"
}