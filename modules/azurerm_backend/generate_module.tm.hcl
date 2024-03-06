generate_hcl "_generated_backend_storage.tf" {
  content {
    module "azurerm_backend" {
      source = "${terramate.stack.path.to_root}/modules/azurerm_backend"

      location               = global.project.defaults.location
      subscription_id        = global.terraform.backend.azurerm.subscription_id
      resource_group_name    = global.terraform.backend.azurerm.resource_group_name
      storage_account_name   = global.terraform.backend.azurerm.storage_account_name
      storage_container_name = global.terraform.backend.azurerm.storage_container_name
    }
  }
}
