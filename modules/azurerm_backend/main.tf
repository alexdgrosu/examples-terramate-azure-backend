terraform {
  required_version = "~> 1.7.0"
}

resource "terraform_data" "backend_storage" {
  triggers_replace = {
    LOCATION               = var.location
    RESOURCE_GROUP_NAME    = var.resource_group_name
    STORAGE_ACCOUNT_NAME   = var.storage_account_name
    STORAGE_CONTAINER_NAME = var.storage_container_name
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
      ACTION = "delete"
    })
  }
}
