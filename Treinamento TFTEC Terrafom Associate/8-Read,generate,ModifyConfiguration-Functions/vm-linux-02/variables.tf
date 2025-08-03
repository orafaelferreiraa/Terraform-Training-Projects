variable "rg_name_lnx2" {
  type = string
}

variable "rg_location_lnx2" {
  type = string
}

variable "nsg_name_lnx2" {
  type = string
}

variable "nsg_rules_lnx2" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "vnet_name_lnx2" {
  type = string
}

variable "vnet_cidr_lnx2" {
  type = list(string)
}

variable "snet_names_lnx2" {
  type    = list(string)
  default = ["snet-01", "snet-02"]
}

variable "vm_count_lnx2" {
  type = string
}

variable "pip_name_lnx2" {
  type = string
}

variable "nic_name_lnx2" {
  type = string
}

variable "vm_name_lnx2" {
  type = string
}

variable "sku_size_lnx2" {
  type = string
}

variable "tags_lnx2" {
  type = map(any)
}
