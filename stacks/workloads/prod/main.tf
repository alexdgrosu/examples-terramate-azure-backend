resource "azurerm_resource_group" "prod" {
  location = var.location
  name     = "rg-workload-${local.resource_suffix}"
}
