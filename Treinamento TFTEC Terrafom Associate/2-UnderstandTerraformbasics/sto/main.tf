data "azurerm_resource_group" "rg-portal" {
  name = "rg-tftec"
}

#local variables
locals {
  storage_account_sku = "Standard"
}

resource "azurerm_storage_account" "storage_tftec" {
  name                     = "st${random_string.random.result}raf"
  resource_group_name      = data.azurerm_resource_group.rg-portal.name
  location                 = data.azurerm_resource_group.rg-portal.location
  account_tier             = local.storage_account_sku
  account_replication_type = var.account_replication_type

  tags = {
    environment = "staging"
  }
}
#variables
variable "account_replication_type" {
  description = "descrição do account_replication_type"
  type        = string
  default     = "GRS"
}

output "storage_account_id" {
  value       = azurerm_storage_account.storage_tftec.id
  description = "ID of the storage account"
}

#random block


resource "random_string" "random" {
  length  = 7
  special = false
  upper   = false
}
