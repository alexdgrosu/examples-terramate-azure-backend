import {
  source = "/modules/azurerm_backend/generate_module.tm.hcl"
}

globals "terraform" "backend" "azurerm" {
  enabled = false
}

globals "terraform" "backend" "local" {
  enabled = true
}
