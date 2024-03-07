resource "azurerm_resource_group" "dev" {
  location = var.location
  name     = "rg-workload-${local.resource_suffix}"
}
