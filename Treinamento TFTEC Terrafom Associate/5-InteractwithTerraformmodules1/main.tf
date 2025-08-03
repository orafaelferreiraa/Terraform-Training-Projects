# Settings Block
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.74.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
}

# Terraform Provider Block
//provider "azurerm" {
//  features {}
//  subscription_id = "xxxx-xxxxxxx-xxxxxxxx-xxxxx-xxxx"
//  client_id       = "xxxx-xxxxxxx-xxxxxxxx-xxxxx-xxxx"
//  client_secret   = "xxxx-xxxxxxx-xxxxxxxx-xxxxx-xxxx"
//  tenant_id       = "xxxx-xxxxxxx-xxxxxxxx-xxxxx-xxxx"
//}

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
  dns_name = "rafael.ferreira.com.br"
  rg_name  = module.rg_module.rg_name_import
}


# Módulos do Terraform Registry

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
}
