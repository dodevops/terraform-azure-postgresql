resource "azurerm_resource_group" "this" {
  name     = "${var.resource-group-name}-${var.stage-suffix}"
  location = var.location
  tags     = { "customer" = "myproject", "managed-by" = "terraform" }
}

module "azure-postgresql" {
  source            = "dodevops/postgresql/azure"
  version           = "0.12.0"
  resource_group    = azurerm_resource_group.this.name
  location          = var.location
  admin_login       = var.dbadmin
  admin_password    = var.dbsecret
  project           = "myproject"
  stage             = var.stage-suffix
  database_flexible = true
  database_version  = 16
  database_suffixes = ["mydatabase"]
  database_host_sku = "B_Standard_B1ms"
  database_storage  = "32768"
  charset           = "UTF8"
  collation         = "de_DE.utf8"
  public_access     = true
  allowed_ips       = { 0 : { start = "0.0.0.0", end = "0.0.0.0" } }
}
