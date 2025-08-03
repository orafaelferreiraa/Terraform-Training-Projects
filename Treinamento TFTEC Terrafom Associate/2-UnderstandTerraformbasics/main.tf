#Settings block

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.35.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}


#module block

module "storage_account" {
  source = "./sto"
}

output "storage_account_id" {
  value       = module.storage_account.storage_account_id
  description = "ID of the storage account"
}

#module rg
module "rg_module" {
  source = "./resource_group"
}

module "dns_zone_module" {
  source   = "./dns_zone"
  rg_name  = module.rg_module.rg_name_import
  dns_name = "rafael.ferreira.com.br"
}

output "dns_id" {
  value = module.dns_zone_module.dns_id
}
