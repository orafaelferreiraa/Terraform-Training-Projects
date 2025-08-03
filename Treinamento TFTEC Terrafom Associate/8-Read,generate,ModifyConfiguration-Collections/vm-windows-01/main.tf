# Coleta de dados Azure KV
data "azurerm_key_vault" "kv-tftec" {
  name                = "kv-tftec-lab"
  resource_group_name = "rg-tftec-kv"
}

data "azurerm_key_vault_secret" "kv-tftec-secret" {
  name         = "tftec-secret"
  key_vault_id = data.azurerm_key_vault.kv-tftec.id
}

#Virtual Machine Windows
resource "azurerm_resource_group" "rg-tftec-win" {
  name     = var.rg_name_win
  location = var.rg_location_win
}

resource "azurerm_network_security_group" "nsg-tftec-win" {
  name                = var.nsg_name_win
  location            = azurerm_resource_group.rg-tftec-win.location
  resource_group_name = azurerm_resource_group.rg-tftec-win.name

  dynamic "security_rule" {
    for_each = var.nsg_rules_win
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_virtual_network" "vnet-tftec-win" {
  name                = var.vnet_name_win
  address_space       = var.vnet_cidr_win
  location            = azurerm_resource_group.rg-tftec-win.location
  resource_group_name = azurerm_resource_group.rg-tftec-win.name
}

resource "azurerm_subnet" "snet-tftec-win" {
  count                = length(var.snet_cidr_win)
  name                 = "${var.snet_name_win}-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.rg-tftec-win.name
  virtual_network_name = azurerm_virtual_network.vnet-tftec-win.name
  address_prefixes     = [var.snet_cidr_win[count.index]]
}

resource "azurerm_public_ip" "pip-tftec-win" {
  name                = var.pip_name_win
  location            = azurerm_resource_group.rg-tftec-win.location
  resource_group_name = azurerm_resource_group.rg-tftec-win.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic-tftec-win" {
  name                = var.nic_name_win
  location            = azurerm_resource_group.rg-tftec-win.location
  resource_group_name = azurerm_resource_group.rg-tftec-win.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.snet-tftec-win[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-tftec-win.id
  }
}

resource "azurerm_virtual_machine" "vm-tftec-win" {
  name                  = var.vm_name_win
  location              = azurerm_resource_group.rg-tftec-win.location
  resource_group_name   = azurerm_resource_group.rg-tftec-win.name
  network_interface_ids = [azurerm_network_interface.nic-tftec-win.id]
  vm_size               = var.sku_size_win

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  dynamic "storage_data_disk" {
    for_each = var.data_disk_sizes_win
    content {
      name              = "datadisk${storage_data_disk.key + 1}"
      managed_disk_type = "Standard_LRS"
      create_option     = "Empty"
      disk_size_gb      = storage_data_disk.value
      lun               = storage_data_disk.key + 1
    }
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "adminuser"
    admin_password = data.azurerm_key_vault_secret.kv-tftec-secret.value
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  tags = var.tags_win
}
