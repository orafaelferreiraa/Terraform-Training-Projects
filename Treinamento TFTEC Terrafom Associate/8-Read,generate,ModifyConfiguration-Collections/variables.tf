variable "rg_name_win" {
  type = string
}

variable "rg_location_win" {
  type = string
}

variable "nsg_name_win" {
  type = string
}

variable "nsg_rules_win" {
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

variable "vnet_name_win" {
  type = string
}

variable "vnet_cidr_win" {
  type = list(string)
}

variable "snet_name_win" {
  type = string
}

variable "snet_cidr_win" {
  type = list(string)
}

variable "pip_name_win" {
  type = string
}

variable "nic_name_win" {
  type = string
}

variable "vm_name_win" {
  type = string
}

variable "sku_size_win" {
  type = string
}

variable "data_disk_sizes_win" {
  type    = tuple([number, number])
  default = [128, 256]
}

variable "provision_vm_agent_win" {
  type = bool
}

variable "tags_win" {
  type = map(any)
}
