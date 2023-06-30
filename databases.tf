resource "azurerm_postgresql_database" "db" {
  for_each            = !var.database_flexible ? toset(var.database_suffixes) : []
  charset             = var.charset
  collation           = var.collation
  name                = "${var.project}${var.stage}db${each.value}"
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_server.server[0].name
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  for_each  = var.database_flexible ? toset(var.database_suffixes) : []
  charset   = var.charset
  collation = var.collation
  name      = "${var.project}${var.stage}db${each.value}"
  server_id = azurerm_postgresql_flexible_server.server[0].id
}
