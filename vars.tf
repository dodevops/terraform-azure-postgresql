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

variable "charset" {
  type        = string
  description = "Charset for the databases, which needs to be a valid PostgreSQL charset"
}

variable "collation" {
  type        = string
  description = <<EOF
    Collation for the databases, which needs to be a valid PostgreSQL collation. Note that Microsoft uses
    different notation - f.e. en-US instead of en_US
  EOF
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
    Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the
    General Purpose and Memory Optimized tiers. This is not support for the Basic tier
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
  default     = "GP_Gen5_2"
  description = "SKU for the database server to use"
}

variable "database_storage" {
  type        = string
  default     = "5120"
  description = "Required database storage (in MB)"
}

variable "public_access" {
  description = "Wether to allow public access to the database server"
  type        = bool
  default     = false
}

variable "allowed_ips" {
  type = map(object({
    start = string,
    end   = string
  }))
  description = <<EOF
    A hash of permissions to access the database server by ip. The hash key is the name suffix and each value
    has a start and an end value. If no allowed_ips is given, the access is public!
  EOF
  default     = {}
}

variable "subnets" {
  type        = map(string)
  description = "Maps of prefix => subnet id that has access to the server"
  default     = {}
}

variable "autogrow" {
  type        = bool
  description = <<EOT
    Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage
    and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the
    workload
    EOT
  default     = true
}