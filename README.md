<div align="center">

# examples-terramate-azure-backend

![https://www.terramate.io/](https://img.shields.io/badge/terramate-9d4ed7?style=for-the-badge&logo=&logoColor=white)![https://www.terraform.io/](https://img.shields.io/badge/terraform-7b42bc?style=for-the-badge&logo=terraform&logoColor=white)![https://azure.microsoft.com/en-us](https://img.shields.io/badge/azure-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white)

Orchestrate your terraform [`azurerm` backend](https://developer.hashicorp.com/terraform/language/settings/backends/azurerm) with [terramate.io](https://terramate.io/).

[TL;DR](#tldr) • [Prerequisites](#prerequisites) • [Orchestration](#orchestration) • [Disclaimers](#disclaimers)

</div>

## TL;DR

This repository serves as an example of how you can use Terramate to orchestrate:

1. the deployment of an `azurerm` backend for Terraform
2. the subsequent initialization of workloads that make use of the `azurerm` backend

This effectively solves the 🐔 and 🥚 remote backend problem[^1] for Terraform by running a single idempotent command.

<details>

<summary><code>$ terramate script run terraform deploy</code></summary>

```shell
Script 0 at /stacks/scripts.tm.hcl:1,1-10,2 having 1 job(s)
/stacks/launchpad (script:0 job:0.0)> terraform init -migrate-state

Initializing the backend...
Initializing modules...

Initializing provider plugins...
- terraform.io/builtin/terraform is built in to Terraform
- Reusing previous version of hashicorp/time from the dependency lock file
- Using previously-installed hashicorp/time v0.10.0

Terraform has been successfully initialized!
/stacks/launchpad (script:0 job:0.1)> terraform validate
Success! The configuration is valid.

/stacks/launchpad (script:0 job:0.2)> terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.azurerm_backend.terraform_data.backend_storage will be created
  + resource "terraform_data" "backend_storage" {
      + id               = (known after apply)
      + triggers_replace = {
          + LOCATION               = "westeurope"
          + RESOURCE_GROUP_NAME    = "rg-tmaz-tf-backend"
          + STORAGE_ACCOUNT_NAME   = "sttmaztfbackend001"
          + STORAGE_CONTAINER_NAME = "tfstate"
          + SUBSCRIPTION_ID        = "eb327489-7718-4d2a-85b8-b669981600e6"
        }
    }

  # module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect will be created
  + resource "time_sleep" "ensure_role_assignments_in_effect" {
      + create_duration = "120s"
      + id              = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
module.azurerm_backend.terraform_data.backend_storage: Creating...
module.azurerm_backend.terraform_data.backend_storage: Provisioning with 'local-exec'...
module.azurerm_backend.terraform_data.backend_storage (local-exec): Executing: ["/bin/bash" "../../modules/azurerm_backend/scripts/manage_azurerm_backend.sh"]
module.azurerm_backend.terraform_data.backend_storage (local-exec): {
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "id": "/subscriptions/eb327489-7718-4d2a-85b8-b669981600e6/resourceGroups/rg-tmaz-tf-backend",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "location": "westeurope",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "managedBy": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "name": "rg-tmaz-tf-backend",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "properties": {
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "provisioningState": "Succeeded"
module.azurerm_backend.terraform_data.backend_storage (local-exec):   },
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "tags": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "type": "Microsoft.Resources/resourceGroups"
module.azurerm_backend.terraform_data.backend_storage (local-exec): }
module.azurerm_backend.terraform_data.backend_storage: Still creating... [10s elapsed]
module.azurerm_backend.terraform_data.backend_storage: Still creating... [20s elapsed]
module.azurerm_backend.terraform_data.backend_storage (local-exec): {
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "accessTier": "Hot",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "accountMigrationInProgress": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "allowBlobPublicAccess": false,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "allowCrossTenantReplication": false,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "allowSharedKeyAccess": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "allowedCopyScope": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "azureFilesIdentityBasedAuthentication": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "blobRestoreStatus": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "creationTime": "2024-03-10T15:53:34.128032+00:00",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "customDomain": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "defaultToOAuthAuthentication": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "dnsEndpointType": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "enableHttpsTrafficOnly": true,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "enableNfsV3": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "encryption": {
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "encryptionIdentity": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "keySource": "Microsoft.Storage",
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "keyVaultProperties": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "requireInfrastructureEncryption": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "services": {
module.azurerm_backend.terraform_data.backend_storage (local-exec):       "blob": {
module.azurerm_backend.terraform_data.backend_storage (local-exec):         "enabled": true,
module.azurerm_backend.terraform_data.backend_storage (local-exec):         "keyType": "Account",
module.azurerm_backend.terraform_data.backend_storage (local-exec):         "lastEnabledTime": "2024-03-10T15:53:34.362407+00:00"
module.azurerm_backend.terraform_data.backend_storage (local-exec):       },
module.azurerm_backend.terraform_data.backend_storage (local-exec):       "file": {
module.azurerm_backend.terraform_data.backend_storage (local-exec):         "enabled": true,
module.azurerm_backend.terraform_data.backend_storage (local-exec):         "keyType": "Account",
module.azurerm_backend.terraform_data.backend_storage (local-exec):         "lastEnabledTime": "2024-03-10T15:53:34.362407+00:00"
module.azurerm_backend.terraform_data.backend_storage (local-exec):       },
module.azurerm_backend.terraform_data.backend_storage (local-exec):       "queue": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):       "table": null
module.azurerm_backend.terraform_data.backend_storage (local-exec):     }
module.azurerm_backend.terraform_data.backend_storage (local-exec):   },
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "extendedLocation": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "failoverInProgress": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "geoReplicationStats": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "id": "/subscriptions/eb327489-7718-4d2a-85b8-b669981600e6/resourceGroups/rg-tmaz-tf-backend/providers/Microsoft.Storage/storageAccounts/sttmaztfbackend001",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "identity": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "immutableStorageWithVersioning": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "isHnsEnabled": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "isLocalUserEnabled": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "isSftpEnabled": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "isSkuConversionBlocked": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "keyCreationTime": {
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "key1": "2024-03-10T15:53:34.346763+00:00",
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "key2": "2024-03-10T15:53:34.346763+00:00"
module.azurerm_backend.terraform_data.backend_storage (local-exec):   },
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "keyPolicy": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "kind": "StorageV2",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "largeFileSharesState": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "lastGeoFailoverTime": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "location": "westeurope",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "minimumTlsVersion": "TLS1_0",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "name": "sttmaztfbackend001",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "networkRuleSet": {
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "bypass": "AzureServices",
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "defaultAction": "Allow",
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "ipRules": [],
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "ipv6Rules": [],
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "resourceAccessRules": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "virtualNetworkRules": []
module.azurerm_backend.terraform_data.backend_storage (local-exec):   },
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "primaryEndpoints": {
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "blob": "https://sttmaztfbackend001.blob.core.windows.net/",
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "dfs": "https://sttmaztfbackend001.dfs.core.windows.net/",
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "file": "https://sttmaztfbackend001.file.core.windows.net/",
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "internetEndpoints": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "microsoftEndpoints": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "queue": "https://sttmaztfbackend001.queue.core.windows.net/",
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "table": "https://sttmaztfbackend001.table.core.windows.net/",
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "web": "https://sttmaztfbackend001.z6.web.core.windows.net/"
module.azurerm_backend.terraform_data.backend_storage (local-exec):   },
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "primaryLocation": "westeurope",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "privateEndpointConnections": [],
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "provisioningState": "Succeeded",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "publicNetworkAccess": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "resourceGroup": "rg-tmaz-tf-backend",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "routingPreference": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "sasPolicy": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "secondaryEndpoints": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "secondaryLocation": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "sku": {
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "name": "Standard_LRS",
module.azurerm_backend.terraform_data.backend_storage (local-exec):     "tier": "Standard"
module.azurerm_backend.terraform_data.backend_storage (local-exec):   },
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "statusOfPrimary": "available",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "statusOfSecondary": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "storageAccountSkuConversionStatus": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "tags": {},
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "type": "Microsoft.Storage/storageAccounts"
module.azurerm_backend.terraform_data.backend_storage (local-exec): }
module.azurerm_backend.terraform_data.backend_storage (local-exec): {
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "created": true
module.azurerm_backend.terraform_data.backend_storage (local-exec): }
module.azurerm_backend.terraform_data.backend_storage: Still creating... [30s elapsed]
module.azurerm_backend.terraform_data.backend_storage (local-exec): {
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "condition": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "conditionVersion": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "createdBy": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "createdOn": "2024-03-10T15:53:59.022776+00:00",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "delegatedManagedIdentityResourceId": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "description": null,
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "id": "/subscriptions/eb327489-7718-4d2a-85b8-b669981600e6/resourceGroups/rg-tmaz-tf-backend/providers/Microsoft.Storage/storageAccounts/sttmaztfbackend001/blobServices/default/containers/tfstate/providers/Microsoft.Authorization/roleAssignments/6fa3103d-ba04-45b8-be79-3d247cd06a54",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "name": "6fa3103d-ba04-45b8-be79-3d247cd06a54",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "principalId": "b6ecb4eb-aa44-4c12-8693-62d6829a8c86",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "principalType": "ServicePrincipal",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "resourceGroup": "rg-tmaz-tf-backend",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "roleDefinitionId": "/subscriptions/eb327489-7718-4d2a-85b8-b669981600e6/providers/Microsoft.Authorization/roleDefinitions/ba92f5b4-2d11-453d-a403-e96b0029c9fe",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "scope": "/subscriptions/eb327489-7718-4d2a-85b8-b669981600e6/resourceGroups/rg-tmaz-tf-backend/providers/Microsoft.Storage/storageAccounts/sttmaztfbackend001/blobServices/default/containers/tfstate",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "type": "Microsoft.Authorization/roleAssignments",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "updatedBy": "b6ecb4eb-aa44-4c12-8693-62d6829a8c86",
module.azurerm_backend.terraform_data.backend_storage (local-exec):   "updatedOn": "2024-03-10T15:53:59.452797+00:00"
module.azurerm_backend.terraform_data.backend_storage (local-exec): }
module.azurerm_backend.terraform_data.backend_storage: Creation complete after 30s [id=a772e272-9143-a81c-3e99-3bd04177026c]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Creating...
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [10s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [20s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [30s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [40s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [50s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [1m0s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [1m10s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [1m20s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [1m30s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [1m40s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [1m50s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Still creating... [2m0s elapsed]
module.azurerm_backend.time_sleep.ensure_role_assignments_in_effect: Creation complete after 2m0s [id=2024-03-10T15:56:03Z]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
/stacks/workloads/dev (script:0 job:0.0)> terraform init -migrate-state

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/azurerm from the dependency lock file
- Using previously-installed hashicorp/azurerm v3.94.0

Terraform has been successfully initialized!
/stacks/workloads/dev (script:0 job:0.1)> terraform validate
Success! The configuration is valid.

/stacks/workloads/dev (script:0 job:0.2)> terraform apply -auto-approve

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
/stacks/workloads/prod (script:0 job:0.0)> terraform init -migrate-state

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/azurerm from the dependency lock file
- Using previously-installed hashicorp/azurerm v3.94.0

Terraform has been successfully initialized!
/stacks/workloads/prod (script:0 job:0.1)> terraform validate
Success! The configuration is valid.

/stacks/workloads/prod (script:0 job:0.2)> terraform apply -auto-approve

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

</details>

## Prerequisites

_Work in progress._

## Orchestration

_Work in progress._

## Disclaimers

_Work in progress._

[^1]: https://www.monterail.com/blog/chicken-or-egg-terraforms-remote-backend/
