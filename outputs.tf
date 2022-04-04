output "server_fqdn" {
  description = "FQDN of the database service"
  value       = local.server_fqdn
}

output "admin_login" {
  value = var.admin_login
}

output "admin_password" {
  value = var.admin_password
}

output "databases" {
  value = var.database_flexible ? (
    length(azurerm_postgresql_flexible_server_database.db) > 0 ? {
      for index, suffix in var.database_suffixes : suffix => azurerm_postgresql_flexible_server_database.db[suffix].name
    } : {}) : (
    length(azurerm_postgresql_database.db) > 0 ? {
      for index, suffix in var.database_suffixes : suffix => azurerm_postgresql_database.db[suffix].name
  } : {})
}
