variable "subscription_id" {
  description = "The subscription ID where the storage account will be created."
  type        = string
}

variable "location" {
  description = "The location/region where the storage account will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the storage account will be created."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account. Must be unique within the storage service."
  type        = string
}

variable "container_name" {
  description = "The name of the storage container. Must be unique within the storage account."
  type        = string
}
