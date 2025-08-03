# Resource Group Import without automatic code generation 
import {
  to = module.rg_module.azurerm_resource_group.rg-import
  id = "/subscriptions/xxxxx/resourceGroups/rg-tftec-import-portal"
}

# Public IP Import with automatic code generation 
import {
  to = azurerm_public_ip.pip-tftec-import
  id = "/subscriptions/xxxxx/resourceGroups/rg-tftec-import-portal/providers/Microsoft.Network/publicIPAddresses/pip-tftec-import-portal"
}
