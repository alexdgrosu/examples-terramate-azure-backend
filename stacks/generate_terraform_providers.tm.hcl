generate_hcl "_generated_terraform_providers.tf" {
  condition = tm_can(global.terraform.providers)

  lets {
    required_providers = { for name, body in tm_try(global.terraform.providers, {}) :
      name => {
        source  = body.source
        version = body.version
      } if tm_try(body.enabled, true)
    }

    providers_configuration = { for name, body in tm_try(global.terraform.providers, {}) :
      name => body.config
      if tm_alltrue([
        tm_try(body.enabled, true),
        tm_can(body.config)
      ])
    }
  }

  content {
    terraform {
      tm_dynamic "required_providers" {
        attributes = let.required_providers
      }
    }

    tm_dynamic "provider" {
      for_each   = let.providers_configuration
      labels     = [provider.key]
      attributes = provider.value

      content {
        tm_dynamic "features" {
          condition = provider.key == "azurerm"
          content {}
        }
      }
    }
  }
}
