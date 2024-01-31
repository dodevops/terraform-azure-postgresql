variable "resource-group-name" {
  type    = string
  default = "postgresqlflexdb"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "stage-suffix" {
  type    = string
  default = "dev"
}

variable "dbadmin" {
  description = "Username for the database administrator"
  type        = string
  default     = "dbadmin"
  sensitive   = true
}

variable "dbsecret" {
  description = "Password for the database administrator"
  type        = string
  sensitive   = true
}

variable "port" {
  description = "Database port"
  type        = string
  default     = "5432"
}

