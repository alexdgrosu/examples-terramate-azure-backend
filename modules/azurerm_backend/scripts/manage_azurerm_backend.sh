#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE:-0}" == "1" ]]; then
    set -o xtrace
fi

function _create {
  local user_name=$(az account show --query user.name -o tsv)
  local subscription_id=$(az account show --query id -o tsv)

  az group create \
    --name "$RESOURCE_GROUP_NAME" \
    --location "$LOCATION"

  az storage account create \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --location "$LOCATION" \
    --allow-blob-public-access false \
    --name "$STORAGE_ACCOUNT_NAME" \
    --sku Standard_LRS \
    --encryption-services blob

  az storage container create \
    --name "$STORAGE_CONTAINER_NAME" \
    --account-name "$STORAGE_ACCOUNT_NAME" \
    --auth-mode login

  az role assignment create \
    --role "Storage Blob Data Contributor" \
    --assignee ${user_name} \
    --scope "/subscriptions/${subscription_id}/resourceGroups/$RESOURCE_GROUP_NAME/providers/Microsoft.Storage/storageAccounts/$STORAGE_ACCOUNT_NAME/blobServices/default/containers/${STORAGE_CONTAINER_NAME}"
}

function _delete {
  az storage container delete \
    --name "$STORAGE_CONTAINER_NAME" \
    --account-name "$STORAGE_ACCOUNT_NAME" \
    --auth-mode login \
    --bypass-immutability-policy

  az storage account delete \
    --name "$STORAGE_ACCOUNT_NAME" \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --yes

  az group delete \
    --name "$RESOURCE_GROUP_NAME" \
    --yes
}

case "$ACTION" in
"create")
  _create
  ;;
"delete")
  _delete
  ;;
*)
  echo "Unsupported action: $ACTION"
  exit 1
  ;;
esac
