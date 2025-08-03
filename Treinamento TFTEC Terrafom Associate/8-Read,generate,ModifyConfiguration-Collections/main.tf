module "vm-windows-01" {
  source = "./vm-windows-01"

  rg_name_win            = var.rg_name_win
  rg_location_win        = var.rg_location_win
  nsg_name_win           = var.nsg_name_win
  nsg_rules_win          = var.nsg_rules_win
  vnet_name_win          = var.vnet_name_win
  vnet_cidr_win          = var.vnet_cidr_win
  snet_name_win          = var.snet_name_win
  snet_cidr_win          = var.snet_cidr_win
  pip_name_win           = var.pip_name_win
  nic_name_win           = var.nic_name_win
  vm_name_win            = var.vm_name_win
  sku_size_win           = var.sku_size_win
  data_disk_sizes_win    = var.data_disk_sizes_win
  provision_vm_agent_win = var.provision_vm_agent_win
  tags_win               = var.tags_win
}
