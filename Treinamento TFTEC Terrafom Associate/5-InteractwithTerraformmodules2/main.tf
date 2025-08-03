# Settings Block
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

# Terraform Modules Block (Exemplo de utilização de módulo)
module "storage_module" {
  source = "./storage_module"
}

# Terraform Output Values Block
output "storage_account_id" {
  value = module.storage_module.storage_account_id
}

# Module Resource Group (Import)
module "rg_module" {
  source = "./resource_group"
}

# DNS Module

module "dns_module_zone" {
  source   = "./dns_zone"
  dns_name = "tfteclab.com.br"
  rg_name  = module.rg_module.rg_name_import
}
#Registry terraform modules

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
  suffix  = ["tftec"]
}

resource "azurerm_resource_group" "rg-naming-module" {
  name     = module.naming.resource_group.name_unique
  location = "West Europe"
}

module "sql_server_module" {
  source      = "./sql_server"
  sql_name    = var.sql_name
  rg_name     = module.rg_module.rg_name_import
  location    = module.rg_module.rg_location
  sql_version = var.sql_version
  sql_admin   = var.sql_admin
  sql_pass    = var.sql_pass
}
