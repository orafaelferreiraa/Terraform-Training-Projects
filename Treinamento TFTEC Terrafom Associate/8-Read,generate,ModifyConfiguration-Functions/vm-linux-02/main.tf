# Coleta de dados Azure KV
data "azurerm_key_vault" "kv-tftec" {
  name                = "kv-tftec-lab"
  resource_group_name = "rg-tftec-kv"
}

data "azurerm_key_vault_secret" "kv-tftec-secret" {
  name         = "tftec-secret"
  key_vault_id = data.azurerm_key_vault.kv-tftec.id
}

resource "azurerm_resource_group" "rg-tftec-loop-lnx2" {
  name     = var.rg_name_lnx2
  location = var.rg_location_lnx2
}

resource "azurerm_network_security_group" "nsg-tftec-loop-lnx2" {
  name                = var.nsg_name_lnx2
  location            = azurerm_resource_group.rg-tftec-loop-lnx2.location
  resource_group_name = azurerm_resource_group.rg-tftec-loop-lnx2.name

  dynamic "security_rule" {
    for_each = var.nsg_rules_lnx2
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

resource "azurerm_virtual_network" "vnet-tftec-loop-lnx2" {
  name                = var.vnet_name_lnx2
  address_space       = var.vnet_cidr_lnx2
  location            = azurerm_resource_group.rg-tftec-loop-lnx2.location
  resource_group_name = azurerm_resource_group.rg-tftec-loop-lnx2.name
}

resource "azurerm_subnet" "snet-tftec-loop-lnx2" {
  for_each             = toset(var.snet_names_lnx2)
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg-tftec-loop-lnx2.name
  virtual_network_name = azurerm_virtual_network.vnet-tftec-loop-lnx2.name
  address_prefixes     = ["10.0.${(each.value == "snet-01") ? 1 : 2}.0/24"]
}

resource "azurerm_public_ip" "pip-tftec-loop-lnx2" {
  count               = var.vm_count_lnx2
  name                = "${var.pip_name_lnx2}-${count.index + 1}"
  location            = azurerm_resource_group.rg-tftec-loop-lnx2.location
  resource_group_name = azurerm_resource_group.rg-tftec-loop-lnx2.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic-tftec-loop-lnx2" {
  count               = var.vm_count_lnx2
  name                = "${var.nic_name_lnx2}-${count.index + 1}"
  location            = azurerm_resource_group.rg-tftec-loop-lnx2.location
  resource_group_name = azurerm_resource_group.rg-tftec-loop-lnx2.name

  ip_configuration {
    name                          = "internal-${count.index + 1}"
    subnet_id                     = azurerm_subnet.snet-tftec-loop-lnx2[var.snet_names_lnx2[count.index]].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-tftec-loop-lnx2[count.index].id
  }
}

resource "azurerm_virtual_machine" "vm-tftec-loop-lnx2" {
  count                 = var.vm_count_lnx2
  name                  = "${var.vm_name_lnx2}-${count.index + 1}"
  location              = azurerm_resource_group.rg-tftec-loop-lnx2.location
  resource_group_name   = azurerm_resource_group.rg-tftec-loop-lnx2.name
  network_interface_ids = [azurerm_network_interface.nic-tftec-loop-lnx2[count.index].id]
  vm_size               = var.sku_size_lnx2

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "linux-${count.index + 1}"
    admin_username = "adminuser"
    admin_password = data.azurerm_key_vault_secret.kv-tftec-secret.value
  }

  connection {
    type     = "ssh"
    host     = azurerm_public_ip.pip-tftec-loop-lnx2[count.index].ip_address
    user     = "adminuser"
    password = data.azurerm_key_vault_secret.kv-tftec-secret.value
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2"
    ]
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = var.tags_lnx2
}
