resource "azurerm_postgresql_database" "db" {
  for_each            = toset(var.database_suffixes)
  charset             = var.charset
  collation           = var.collation
  name                = "${var.project}${var.stage}db${each.value}"
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_server.server.name
}