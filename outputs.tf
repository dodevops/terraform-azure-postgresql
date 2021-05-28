output "resource_group" {
  description = "The name of the generated resource group"
  value       = azurerm_resource_group.azure-resource-group.name
}

output "location" {
  description = "The location input variable (can be used for dependency resolution)"
  value       = var.location
}

output "ppg_id" {
  description = "The ID of the generated proximity placement group"
  value       = azurerm_proximity_placement_group.ppg.id
}
