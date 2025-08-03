# Settings Block
terraform {
  backend "azurerm" {
    access_key           = "xxxxx" 
    storage_account_name = "xxx"                                                                      
    container_name       = "x"                                                                               
    key                  = "xxxx"                                                                      
  }
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
