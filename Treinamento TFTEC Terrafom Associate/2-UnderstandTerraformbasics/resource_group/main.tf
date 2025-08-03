resource "azurerm_resource_group" "rg-import" {
  name     = "rg-tftec"
  location = "eastus"
  tags     = { import = "ok" }
}
