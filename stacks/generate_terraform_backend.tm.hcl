generate_hcl "_generated_azurerm_backend.tf" {
  lets {
    required_version = tm_try(global.terraform.version, "~> 1.7")
    key              = "${global.project.moniker}/${terramate.stack.path.relative}/terraform.tfstate"
  }

  content {
    terraform {
      required_version = let.required_version

      tm_dynamic "backend" {
        condition  = tm_try(global.terraform.backend.local.enabled, false)
        labels     = ["local"]
        attributes = tm_try(global.terraform.backend.local.config, {})
      }

      tm_dynamic "backend" {
        condition  = tm_try(global.terraform.backend.azurerm.enabled, false)
        labels     = ["azurerm"]
        attributes = tm_try(global.terraform.backend.azurerm.config, {})

        content {
          key      = let.key
          snapshot = true
        }
      }
    }
  }
}
