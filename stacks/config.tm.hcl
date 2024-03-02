globals "terraform" {
  required_version = "~> 1.7.4"
}

globals "terraform" "backend" {
  storage_container_name = "tfstate"
  storage_account_name   = "st${global.project.moniker}tfbackend${tm_format("%03d", global.project.revision)}"
  resource_group_name    = "rg-${global.project.moniker}-tf-backend"
}

globals "project" {
  moniker  = "tmaz"
  revision = 1

  defaults = {
    location = "westeurope"
  }
}
