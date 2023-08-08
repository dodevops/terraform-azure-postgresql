variable "location" {
  type        = string
  description = "The azure location used for azure"
}

variable "project" {
  type        = string
  description = "Three letter project key"
}

variable "stage" {
  type        = string
  description = "Stage for this ressource group"
}

variable "resource_group" {
  type        = string
  description = "Azure Resource Group to use"
}

variable "database_suffixes" {
  type        = list(string)
  description = "List of suffixes for databases to be created"
}

variable "database_version" {
  type        = string
  description = "Database version to use"
  default     = "11"
}

variable "suffix" {
  type        = string
  description = "Naming suffix to allow multiple instances of this module"
  default     = ""
}

variable "charset" {
  type        = string
  description = <<-EOT
    Charset for the databases, which needs to be a
    [valid PostgreSQL charset](https://www.postgresql.org/docs/current/multibyte.html).
  EOT
}

variable "collation" {
  type        = string
  description = <<-EOT
    Collation for the databases, which needs to be a
    [valid PostgreSQL collation](https://www.postgresql.org/docs/current/collation.html).
    *For single server* Microsoft uses different notation - f.e. en-US instead of en_US
  EOT
}
variable "backup_retention_days" {
  type        = number
  description = "Number of days to keep backups"
  default     = 7
  validation {
    condition     = var.backup_retention_days >= 7 && var.backup_retention_days <= 35
    error_message = "Backup retention days has to be between 7 and 35 including."
  }
}

variable "geo_redundant_backup_enabled" {
  type        = bool
  description = <<-EOT
    Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant
    backup storage in the General Purpose and Memory Optimized tiers. This is not supported for the Basic tier
    (only single server)
  EOT
  default     = false
}

variable "admin_login" {
  type        = string
  description = "Admin login"
  default     = "psql"
}

variable "admin_password" {
  type        = string
  description = "Admin password"
}

variable "database_host_sku" {
  type        = string
  description = <<-EOT
    SKU for the database server to use. Single server uses values like GP_Gen5_2, flexible server uses Azure
    machine SKUs with a tier prefix like GP_Standard_D2s_v38. See the
    [Microsoft documentation](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage)
    on what machine types are available for PostgreSQL.
  EOT
  default     = "GP_Gen5_2"
}

variable "database_storage" {
  type        = string
  description = <<-EOT
    Required database storage (in MB) (flexible server has a defined set of storage sizes to select from.
    See https://docs.microsoft.com/de-de/azure/postgresql/flexible-server/concepts-compute-storage#storage
  EOT
  default     = "5120"
}

variable "database_flexible" {
  type        = bool
  description = "Whether to use Azure's flexible database service"
  default     = false
}

variable "public_access" {
  type        = bool
  description = <<-EOT
    Wether to allow public access to the database server. True will create firewall rules for allowed_ips and for
    subnets. False will create a private endpoint in each given subnet (allowed_ips will not be used then) - you have
    to set `enforce_private_link_endpoint_network_policies = true` on your subnet in this case (see
    the [Terraform subnet resource documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#enforce_private_link_endpoint_network_policies)).
    (false currently not supported for flexible server)
  EOT
  default     = false
}

variable "allowed_ips" {
  type = map(object({
    start = string,
    end   = string
  }))
  description = <<-EOT
    A hash of permissions to access the database server by ip. The hash key is the name suffix and each value
    has a start and an end value.

    * For public access set start to 0.0.0.0 and end to 255.255.255.255.
    * For access from all Azure services set start and end to 0.0.0.0

    This variable is not used if public_access = false.
  EOT
  default     = {}
}

variable "subnets" {
  type        = map(string)
  description = "Maps of prefix => subnet id that has access to the server  (only single server)"
  default     = {}
}

variable "autogrow" {
  type        = bool
  description = <<-EOT
    Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage
    and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the
    workload (only single server)
    EOT
  default     = true
}

variable "params" {
  type        = map(string)
  description = "A map of server parameters to set"
  default     = {}
}

variable "availability_zone" {
  type        = number
  default     = 1
  description = "The availability zone the Flexible Server should be placed in (only flexible server)"
}
