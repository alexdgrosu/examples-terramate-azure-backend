generate_hcl "_generated_backend_storage.tf" {
  content {
    tm_dynamic "module" {
      labels     = ["azurerm_backend"]
      attributes = global.terraform.backend.azurerm.config

      content {
        source = "${terramate.stack.path.to_root}/modules/azurerm_backend"

        subscription_id = global.project.subscriptions.launchpad
        location        = global.project.defaults.location
      }
    }
  }
}
