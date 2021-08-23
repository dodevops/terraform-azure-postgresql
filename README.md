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

No requirements.

## Providers

The following providers are used by this module:

- azurerm

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_postgresql_database.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_database) (resource)
- [azurerm_postgresql_firewall_rule.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_firewall_rule) (resource)
- [azurerm_postgresql_firewall_rule.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_firewall_rule) (resource)
- [azurerm_postgresql_server.server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server) (resource)
- [azurerm_postgresql_virtual_network_rule.virtualnetworks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_virtual_network_rule) (resource)

## Required Inputs

The following input variables are required:

### admin\_password

Description: Admin password

Type: `string`

### charset

Description: Charset for the databases, which needs to be a valid PostgreSQL charset

Type: `string`

### collation

Description:     Collation for the databases, which needs to be a valid PostgreSQL collation. Note that Microsoft uses  
    different notation - f.e. en-US instead of en\_US

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
    has a start and an end value. If no allowed\_ips is given, the access is public!

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
    workload

Type: `bool`

Default: `true`

### backup\_retention\_days

Description: Number of days to keep backups

Type: `number`

Default: `7`

### database\_host\_sku

Description: SKU for the database server to use

Type: `string`

Default: `"GP_Gen5_2"`

### database\_storage

Description: Required database storage (in MB)

Type: `string`

Default: `"5120"`

### database\_version

Description: Database version to use

Type: `string`

Default: `"11"`

### geo\_redundant\_backup\_enabled

Description:     Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the  
    General Purpose and Memory Optimized tiers. This is not support for the Basic tier

Type: `bool`

Default: `false`

### public\_access

Description: Wether to allow public access to the database server

Type: `bool`

Default: `false`

### subnets

Description: Maps of prefix => subnet id that has access to the server

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
<!-- END_TF_DOCS -->

## Development

Use [terraform-docs](https://terraform-docs.io/) to generate the API documentation by running

    terraform fmt .
    terraform-docs .
