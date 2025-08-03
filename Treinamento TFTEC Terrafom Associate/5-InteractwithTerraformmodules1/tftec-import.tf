# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "/subscriptions/677da638-8378-42fe-8760-44325833da25/resourceGroups/rg-tftec-import-portal/providers/Microsoft.Network/publicIPAddresses/pip-tftec-import-portal"
resource "azurerm_public_ip" "pip-tftec-import" {
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  ddos_protection_plan_id = null
  domain_name_label       = null
  edge_zone               = null
  idle_timeout_in_minutes = 4
  ip_tags                 = {
    funciona = "SIM"
  }
  ip_version              = "IPv4"
  location                = "eastus"
  name                    = "pip-tftec-import-portal"
  public_ip_prefix_id     = null
  resource_group_name     = "rg-tftec-import-portal"
  reverse_fqdn            = null
  sku                     = "Standard"
  sku_tier                = "Regional"
  tags                    = {}
  zones                   = ["1", "2", "3"]
}
