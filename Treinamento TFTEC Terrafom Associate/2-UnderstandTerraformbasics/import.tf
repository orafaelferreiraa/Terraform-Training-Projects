# import resource group
import {
  to = module.rg_module.azurerm_resource_group.rg-import
  id = "/subscriptions/xxxxx/resourceGroups/rg-tftec"
}

#import pip
import {
  to = azurerm_public_ip.pip-import
  id = "/subscriptions/xxxxx/resourceGroups/rg-tftec/providers/Microsoft.Network/publicIPAddresses/pip-tftec-import-portal"
}
