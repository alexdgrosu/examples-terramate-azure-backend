// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  required_version = "~> 1.7"
  backend "azurerm" {
    container_name       = "tfstate"
    resource_group_name  = "rg-tmaz-tf-backend"
    storage_account_name = "sttmaztfbackend001"
    key                  = "tmaz/stacks/workloads/prod/terraform.tfstate"
    snapshot             = true
  }
}
