variable "rg_name" {
  type        = string
  description = "Nome do resource group"
}

variable "rg_location" {
  type        = string
  description = "Regiao do resource group"
}

variable "nsg_name" {
  type        = string
  description = "Nome do NSG"
}

variable "vnet_name" {
  type        = string
  description = "Nome da VNET"
}

variable "vnet_cidr" {
  type        = list(string)
  description = "Rede da VNET"
}

variable "snet_name" {
  type        = string
  description = "Nome da subnet"
}

variable "vnet_snet" {
  type        = list(string)
  description = "Rede da subnet"
}

variable "pip_name" {
  type        = string
  description = "Nome do ip publico"
}

variable "nic_name" {
  type        = string
  description = "Name da NIC"
}

variable "vm_name" {
  type        = string
  description = "Nome da VM"
}

variable "vm_sku" {
  type        = string
  description = "SKU da VM"
}