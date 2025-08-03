module "vm-linux-01" {
  source = "./vm-linux-01"

  rg_name     = var.rg_name
  rg_location = var.rg_location
  nsg_name    = var.nsg_name
  vnet_name   = var.vnet_name
  vnet_cidr   = var.vnet_cidr
  snet_name   = var.snet_name
  vnet_snet   = var.vnet_snet
  pip_name    = var.pip_name
  nic_name    = var.nic_name
  vm_name     = var.vm_name
  vm_sku      = var.vm_sku
}