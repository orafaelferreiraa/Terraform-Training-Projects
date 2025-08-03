resource "azurerm_resource_group" "rg-import" {
  name     = "rg-tftec-import-portal"
  location = "eastus2"
  tags = {
    import = "OK"
  }
}
