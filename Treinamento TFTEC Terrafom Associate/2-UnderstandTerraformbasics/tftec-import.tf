# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "/subscriptions/67679a5f-45e1-4949-87ac-25df76d12478/resourceGroups/rg-tftec/providers/Microsoft.Network/publicIPAddresses/pip-tftec-import-portal"
resource "azurerm_public_ip" "pip-import" {
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  ddos_protection_plan_id = null
  domain_name_label       = null
  domain_name_label_scope = null
  edge_zone               = null
  idle_timeout_in_minutes = 4
  ip_tags                 = {}
  ip_version              = "IPv4"
  location                = "eastus"
  name                    = "pip-tftec-import-portal"
  public_ip_prefix_id     = null
  resource_group_name     = "rg-tftec"
  reverse_fqdn            = null
  sku                     = "Standard"
  sku_tier                = "Regional"
  tags = {
    funiona = "sim"
  }
  zones = ["1", "2", "3"]
}
