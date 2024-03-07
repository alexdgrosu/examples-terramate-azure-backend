globals "terraform" "providers" "azurerm" {
  enabled = true

  source  = "hashicorp/azurerm"
  version = "= 3.94.0"

  config = {
    skip_provider_registration = true
    subscription_id            = tm_lookup(global.project.subscriptions.workloads, terramate.stack.path.basename)
  }
}
