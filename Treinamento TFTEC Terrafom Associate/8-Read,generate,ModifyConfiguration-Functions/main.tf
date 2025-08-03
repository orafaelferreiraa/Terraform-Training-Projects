module "vm-linux-02" {
  source = "./vm-linux-02"

  rg_name_lnx2     = var.rg_name_lnx2
  rg_location_lnx2 = var.rg_location_lnx2
  nsg_name_lnx2    = var.nsg_name_lnx2
  nsg_rules_lnx2   = var.nsg_rules_lnx2
  vnet_name_lnx2   = var.vnet_name_lnx2
  vnet_cidr_lnx2   = var.vnet_cidr_lnx2
  snet_names_lnx2  = var.snet_names_lnx2
  vm_count_lnx2    = var.vm_count_lnx2
  pip_name_lnx2    = var.pip_name_lnx2
  nic_name_lnx2    = var.nic_name_lnx2
  vm_name_lnx2     = var.vm_name_lnx2
  sku_size_lnx2    = var.sku_size_lnx2
  tags_lnx2        = var.tags_lnx2
}
