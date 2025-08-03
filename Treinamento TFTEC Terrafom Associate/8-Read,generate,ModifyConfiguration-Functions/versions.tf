# Settings Block
terraform {
  backend "azurerm" {
    access_key           = "xxxxx" # Can also be set via `ARM_ACCESS_KEY` environment variable.
    storage_account_name = "xxx"                                                                      # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "x"                                                                                # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "xxxx"                                                                  # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
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
