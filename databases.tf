resource "azurerm_postgresql_database" "db" {
  for_each            = toset(var.database_suffixes)
  charset             = "UTF8"
  collation           = "en-US"
  name                = "${var.project}${var.stage}db${each.value}"
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_server.server.name
}
