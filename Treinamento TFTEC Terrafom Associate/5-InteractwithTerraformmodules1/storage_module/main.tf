# 1 - Terraform Data Block (Resource Group)
data "azurerm_resource_group" "rg_portal" {
  name = "rg-tftec-data-block-portal"
}

# 2 - Terraform Local Variables Block
locals {
  storage_account_sku = "Standard"
}

# 3 - Terraform Resource Block (Storage Account)
resource "azurerm_storage_account" "storage_tftec" {
  name                     = "tftec${random_string.resource_code.result}"
  resource_group_name      = data.azurerm_resource_group.rg_portal.name
  location                 = data.azurerm_resource_group.rg_portal.location
  account_tier             = local.storage_account_sku
  account_replication_type = var.account_replication_type

  tags = {
    environment = "staging"
  }
}

# 4 - Terraform Input Variables Block
variable "account_replication_type" {
  description = "Tipo da Replica da Storage"
  type        = string
  default     = "GRS"
}

# 5 - Terraform Output Values Block
output "storage_account_id" {
  value = azurerm_storage_account.storage_tftec.id
}

# 6 - Radom String Block
resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}