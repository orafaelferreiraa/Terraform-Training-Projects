# Coletando informacoes do Azure Key Vault 
data "azurerm_key_vault" "kv-tftec" {
  name                = "kv-tftec-02"
  resource_group_name = "rg-tftec-kv"
}

data "azurerm_key_vault_secret" "kv-tftec-secret" {
  name         = "tftec-secret" # Nome correto do segredo no Key Vault
  key_vault_id = data.azurerm_key_vault.kv-tftec.id
}

# Resource Group
resource "azurerm_resource_group" "rg-tftec-lnx" {
  name     = var.rg_name
  location = var.rg_location
}

# NSG para habilitar o acesso a porta 22 SSH
resource "azurerm_network_security_group" "vm_nsg" {
  name                = var.nsg_name
  resource_group_name = azurerm_resource_group.rg-tftec-lnx.name
  location            = azurerm_resource_group.rg-tftec-lnx.location

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "vnet-tftec-lnx" {
  name                = var.vnet_name
  address_space       = var.vnet_cidr
  location            = azurerm_resource_group.rg-tftec-lnx.location
  resource_group_name = azurerm_resource_group.rg-tftec-lnx.name
}

resource "azurerm_subnet" "snet-tftec-lnx" {
  name                 = var.snet_name
  resource_group_name  = azurerm_resource_group.rg-tftec-lnx.name
  virtual_network_name = azurerm_virtual_network.vnet-tftec-lnx.name
  address_prefixes     = var.vnet_snet
}

resource "azurerm_public_ip" "public_ip" {
  name                = var.pip_name
  location            = azurerm_resource_group.rg-tftec-lnx.location
  resource_group_name = azurerm_resource_group.rg-tftec-lnx.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic-tftec-lnx-01" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg-tftec-lnx.location
  resource_group_name = azurerm_resource_group.rg-tftec-lnx.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.snet-tftec-lnx.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_virtual_machine" "vm-tftec-lnx" {
  name                  = var.vm_name
  location              = azurerm_resource_group.rg-tftec-lnx.location
  resource_group_name   = azurerm_resource_group.rg-tftec-lnx.name
  network_interface_ids = [azurerm_network_interface.nic-tftec-lnx-01.id]
  vm_size               = var.vm_sku

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk01"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "adminuser"
    admin_password = data.azurerm_key_vault_secret.kv-tftec-secret.value
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}