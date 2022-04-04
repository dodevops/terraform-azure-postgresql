resource "azurerm_postgresql_flexible_server_configuration" "pgbouncer" {
  count     = var.database_flexible ? 1 : 0
  name      = "pgbouncer.enabled"
  value     = "true"
  server_id = azurerm_postgresql_flexible_server.server.0.id
}
