# Azure DB for PostgreSQL

## Introduction

This module manages resources for Azure DB for PostgreSQL.

## Usage

Instantiate the module by calling it from Terraform like this:

```hcl
module "azure-postgresql" {
  source  = "dodevops/postgresql/azure"
  version = "<version>"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- terraform (>=1.0.0)

- azurerm (>=3.63.0)

## Providers

The following providers are used by this module:

- azurerm (>=3.63.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_postgresql_configuration.connection-throttling-flexible](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration) (resource)
- [azurerm_postgresql_configuration.connection-throttling-normal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration) (resource)
- [azurerm_postgresql_configuration.log-checkpoints-flexible](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration) (resource)
- [azurerm_postgresql_configuration.log-checkpoints-normal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration) (resource)
- [azurerm_postgresql_configuration.log-connections-flexible](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration) (resource)
- [azurerm_postgresql_configuration.log-connections-normal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration) (resource)
- [azurerm_postgresql_configuration.params](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration) (resource)
- [azurerm_postgresql_database.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_database) (resource)
- [azurerm_postgresql_firewall_rule.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_firewall_rule) (resource)
- [azurerm_postgresql_flexible_server.server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) (resource)
- [azurerm_postgresql_flexible_server_configuration.params](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) (resource)
- [azurerm_postgresql_flexible_server_configuration.pgbouncer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) (resource)
- [azurerm_postgresql_flexible_server_database.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) (resource)
- [azurerm_postgresql_flexible_server_firewall_rule.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule) (resource)
- [azurerm_postgresql_server.server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server) (resource)
- [azurerm_postgresql_virtual_network_rule.virtualnetworks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_virtual_network_rule) (resource)
- [azurerm_private_endpoint.postgresql-private-endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) (resource)

## Required Inputs

The following input variables are required:

### admin\_password

Description: Admin password

Type: `string`

### charset

Description: Charset for the databases, which needs to be a valid PostgreSQL charset

Type: `string`

### collation

Description:     Collation for the databases, which needs to be a valid PostgreSQL collation. Note that *for single server* Microsoft  
    uses different notation - f.e. en-US instead of en\_US. *For flexible server*, PostgreSQL standard collations are  
    used.

Type: `string`

### database\_suffixes

Description: List of suffixes for databases to be created

Type: `list(string)`

### location

Description: The azure location used for azure

Type: `string`

### project

Description: Three letter project key

Type: `string`

### resource\_group

Description: Azure Resource Group to use

Type: `string`

### stage

Description: Stage for this ressource group

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### admin\_login

Description: Admin login

Type: `string`

Default: `"psql"`

### allowed\_ips

Description:     A hash of permissions to access the database server by ip. The hash key is the name suffix and each value  
    has a start and an end value. For public access set start\_ip\_address to 0.0.0.0 and end\_ip\_address to  
    255.255.255.255. This variable is not used if public\_access = false.

Type:

```hcl
map(object({
    start = string,
    end   = string
  }))
```

Default: `{}`

### autogrow

Description:     Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage  
    and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the  
    workload (only single server)

Type: `bool`

Default: `true`

### availability\_zone

Description: The availability zone the Flexible Server should be placed in (only flexible server)

Type: `number`

Default: `1`

### backup\_retention\_days

Description: Number of days to keep backups

Type: `number`

Default: `7`

### database\_flexible

Description: Whether to use Azure's flexible database service

Type: `bool`

Default: `false`

### database\_host\_sku

Description:     SKU for the database server to use. Single server uses values like GP\_Gen5\_2, flexible server uses Azure  
    machine SKUs like GP\_Standard\_D2s\_v3

Type: `string`

Default: `"GP_Gen5_2"`

### database\_storage

Description:     Required database storage (in MB) (flexible server has a defined set of storage sizes to select from.  
    See https://docs.microsoft.com/de-de/azure/postgresql/flexible-server/concepts-compute-storage#storage

Type: `string`

Default: `"5120"`

### database\_version

Description: Database version to use

Type: `string`

Default: `"11"`

### geo\_redundant\_backup\_enabled

Description:     Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant  
    backup storage in the General Purpose and Memory Optimized tiers. This is not support for the Basic tier
    (only single server)

Type: `bool`

Default: `false`

### params

Description: A map of server parameters to set

Type: `map(string)`

Default: `{}`

### public\_access

Description:     Wether to allow public access to the database server. True will create firewall rules for allowed\_ips and for  
    subnets. False will create a private endpoint in each given subnet (allowed\_ips will not be used then) - you have  
    to set `enforce_private_link_endpoint_network_policies = true` on your subnet in this case (see  
    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#enforce_private_link_endpoint_network_policies).
    (false currently not supported for flexible server)

Type: `bool`

Default: `false`

### subnets

Description: Maps of prefix => subnet id that has access to the server  (only single server)

Type: `map(string)`

Default: `{}`

### suffix

Description: Naming suffix to allow multiple instances of this module

Type: `string`

Default: `""`

## Outputs

The following outputs are exported:

### admin\_login

Description: n/a

### admin\_password

Description: n/a

### databases

Description: n/a

### server\_fqdn

Description: FQDN of the database service

### server\_id

Description: ID of the database server
<!-- END_TF_DOCS -->

## Development

Use [the terraform module tools](https://github.com/dodevops/terraform-module-tools) to check and generate the documentation by running

    docker run -v "$PWD":/terraform ghcr.io/dodevops/terraform-module-tools:latest
