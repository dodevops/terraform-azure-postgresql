resource "azurerm_postgresql_flexible_server_configuration" "pgbouncer" {
  count     = var.database_flexible ? 1 : 0
  name      = "pgbouncer.enabled"
  value     = "true"
  server_id = azurerm_postgresql_flexible_server.server[0].id
}

resource "azurerm_postgresql_flexible_server_configuration" "params" {
  for_each  = var.database_flexible ? var.params : {}
  name      = each.key
  value     = each.value
  server_id = azurerm_postgresql_flexible_server.server[0].id
}

resource "azurerm_postgresql_configuration" "params" {
  for_each            = !var.database_flexible ? var.params : {}
  name                = each.key
  value               = each.value
  resource_group_name = var.resource_group
  server_name         = local.server_name
}
