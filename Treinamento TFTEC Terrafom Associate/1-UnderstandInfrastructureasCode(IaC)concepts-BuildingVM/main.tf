# Create Resource Group
resource "azurerm_resource_group" "rg-tftec" {
  name     = "rg-tftec-from-terraform"
  location = "brazilsouth"
}

# Create Virtual Network (VNet)
resource "azurerm_virtual_network" "vnet-tftec" {
  name                = "vnet-tftec-from-terraform"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-tftec.location
  resource_group_name = azurerm_resource_group.rg-tftec.name
}

# Create subnet on VNet
resource "azurerm_subnet" "sub-tftec" {
  name                 = "sub-tftec-from-terraform"
  resource_group_name  = azurerm_resource_group.rg-tftec.name
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.vnet-tftec.name
}

# Create subnet on VNet
resource "azurerm_subnet" "sub-tftec-02" {
  name                 = "sub-tftec-from-terraform-02"
  resource_group_name  = azurerm_resource_group.rg-tftec.name
  address_prefixes     = ["10.0.2.0/24"]
  virtual_network_name = azurerm_virtual_network.vnet-tftec.name
}

# Create Network Security Group (NSG)
resource "azurerm_network_security_group" "nsg-tftec" {
  name                = "nsg-tftec-from-terraform"
  location            = azurerm_resource_group.rg-tftec.location
  resource_group_name = azurerm_resource_group.rg-tftec.name

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

# Create Public IP
resource "azurerm_public_ip" "pip-tftec" {
  name                = "pip-tftec-from-terraform"
  location            = azurerm_resource_group.rg-tftec.location
  resource_group_name = azurerm_resource_group.rg-tftec.name
  allocation_method   = "Static"
}

# Create Network Internface
resource "azurerm_network_interface" "nic-tftec" {
  name                = "nic-tftec-from-terraform"
  location            = azurerm_resource_group.rg-tftec.location
  resource_group_name = azurerm_resource_group.rg-tftec.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub-tftec.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-tftec.id
  }
}

# Create Virtual Machine Linux
resource "azurerm_virtual_machine" "vm-tftec" {
  name                  = "vm-tftec-from-terraform"
  location              = azurerm_resource_group.rg-tftec.location
  resource_group_name   = azurerm_resource_group.rg-tftec.name
  network_interface_ids = [azurerm_network_interface.nic-tftec.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-tftec-from-terraform"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "tftecprime"
    admin_username = "adminuser"
    admin_password = "Password12345!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  delete_os_disk_on_termination = true

  tags = {
    environment = "tftec"
    provisioner = "terraform"
    aula01      = "new-tag"
  }
}