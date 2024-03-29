terraform {
  required_version = "~> 1.7.0"

  required_providers {
    time = {
      source  = "hashicorp/time"
      version = ">= 0.10.0, < 1.0.0"
    }
  }
}

resource "terraform_data" "backend_storage" {
  triggers_replace = {
    SUBSCRIPTION_ID        = var.subscription_id
    LOCATION               = var.location
    RESOURCE_GROUP_NAME    = var.resource_group_name
    STORAGE_ACCOUNT_NAME   = var.storage_account_name
    STORAGE_CONTAINER_NAME = var.container_name
  }

  provisioner "local-exec" {
    command     = "${path.module}/scripts/manage_azurerm_backend.sh"
    interpreter = ["/bin/bash"]
    on_failure  = fail
    when        = create
    environment = merge(self.triggers_replace, {
      ACTION = "create"
    })
  }

  provisioner "local-exec" {
    command     = "${path.module}/scripts/manage_azurerm_backend.sh"
    interpreter = ["/bin/bash"]
    on_failure  = continue
    when        = destroy
    environment = merge(self.triggers_replace, {
      ACTION = "destroy"
    })
  }
}

resource "time_sleep" "ensure_role_assignments_in_effect" {
  depends_on = [terraform_data.backend_storage]

  create_duration = "120s"
}
