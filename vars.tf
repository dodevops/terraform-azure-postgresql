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
  description = "Charset for the databases, which needs to be a valid PostgreSQL charset"
}

variable "collation" {
  type        = string
  description = <<EOF
    Collation for the databases, which needs to be a valid PostgreSQL collation. Note that *for single server* Microsoft
    uses different notation - f.e. en-US instead of en_US. *For flexible server*, PostgreSQL standard collations are
    used.
  EOF
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
  description = <<EOF
    Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant
    backup storage in the General Purpose and Memory Optimized tiers. This is not support for the Basic tier
    (only single server)
  EOF
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
  description = <<EOF
    SKU for the database server to use. Single server uses values like GP_Gen5_2, flexible server uses Azure
    machine SKUs like GP_Standard_D2s_v3
  EOF
  default     = "GP_Gen5_2"
}

variable "database_storage" {
  type        = string
  description = <<EOF
    Required database storage (in MB) (flexible server has a defined set of storage sizes to select from.
    See https://docs.microsoft.com/de-de/azure/postgresql/flexible-server/concepts-compute-storage#storage
  EOF
  default     = "5120"
}

variable "database_flexible" {
  type        = bool
  description = "Whether to use Azure's flexible database service"
  default     = false
}

variable "public_access" {
  type        = bool
  description = <<EOF
    Wether to allow public access to the database server. True will create firewall rules for allowed_ips and for
    subnets. False will create a private endpoint in each given subnet (allowed_ips will not be used then) - you have
    to set `enforce_private_link_endpoint_network_policies = true` on your subnet in this case (see
    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#enforce_private_link_endpoint_network_policies).
    (false currently not supported for flexible server)
  EOF
  default     = false
}

variable "allowed_ips" {
  type = map(object({
    start = string,
    end   = string
  }))
  description = <<EOF
    A hash of permissions to access the database server by ip. The hash key is the name suffix and each value
    has a start and an end value. For public access set start_ip_address to 0.0.0.0 and end_ip_address to
    255.255.255.255. This variable is not used if public_access = false.
  EOF
  default     = {}
}

variable "subnets" {
  type        = map(string)
  description = "Maps of prefix => subnet id that has access to the server  (only single server)"
  default     = {}
}

variable "autogrow" {
  type        = bool
  description = <<EOT
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
