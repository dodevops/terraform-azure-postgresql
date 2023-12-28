output "server_fqdn" {
  description = "FQDN of the database service"
  value       = local.server_fqdn
}

output "server_id" {
  description = "ID of the database server"
  value       = var.database_flexible ? azurerm_postgresql_flexible_server.server[0].id : azurerm_postgresql_server.server[0].id
}

output "admin_login" {
  description = "The administrative username"
  value       = var.admin_login
}

output "admin_password" {
  description = "The password of the administrative user"
  value       = var.admin_password
}

output "databases" {
  description = "Names of the created databases"
  value = var.database_flexible ? (
    length(azurerm_postgresql_flexible_server_database.db) > 0 ? {
      for index, suffix in var.database_suffixes : suffix => azurerm_postgresql_flexible_server_database.db[suffix].name
    } : {}) : (
    length(azurerm_postgresql_database.db) > 0 ? {
      for index, suffix in var.database_suffixes : suffix => azurerm_postgresql_database.db[suffix].name
  } : {})
}

output "database_ids" {
  description = "IDs of the created databases"
  value = var.database_flexible ? (
    length(azurerm_postgresql_flexible_server_database.db) > 0 ? {
      for index, suffix in var.database_suffixes : suffix => azurerm_postgresql_flexible_server_database.db[suffix].id
    } : {}) : (
    length(azurerm_postgresql_database.db) > 0 ? {
      for index, suffix in var.database_suffixes : suffix => azurerm_postgresql_database.db[suffix].id
  } : {})
}
