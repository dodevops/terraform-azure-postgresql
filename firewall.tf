resource "azurerm_postgresql_firewall_rule" "firewall" {
  for_each            = !var.database_flexible && var.public_access == true ? var.allowed_ips : {}
  start_ip_address    = each.value.start
  end_ip_address      = each.value.end
  name                = "${var.project}${var.stage}dbfw${each.key}"
  resource_group_name = var.resource_group
  server_name         = local.server_name
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "firewall" {
  for_each         = var.database_flexible && var.public_access == true ? var.allowed_ips : {}
  start_ip_address = each.value.start
  end_ip_address   = each.value.end
  name             = "${var.project}${var.stage}dbfw${each.key}"
  server_id        = azurerm_postgresql_flexible_server.server.0.id
}

resource "azurerm_postgresql_virtual_network_rule" "virtualnetworks" {
  for_each            = !var.database_flexible && var.public_access == true ? var.subnets : {}
  name                = "${var.project}${var.stage}dbfwnet${each.key}"
  resource_group_name = var.resource_group
  server_name         = local.server_name
  subnet_id           = each.value
}

resource "azurerm_private_endpoint" "postgresql-private-endpoint" {
  for_each            = !var.database_flexible && var.public_access == true ? var.subnets : {}
  name                = "${each.value}-postgresql-${azurerm_postgresql_server.server.0.id}-endpoint"
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = each.value

  private_service_connection {
    name                           = "${each.value}-postgresql-${azurerm_postgresql_server.server.0.id}-privateserviceconnection"
    private_connection_resource_id = azurerm_postgresql_server.server.0.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }
}
