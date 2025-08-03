resource "azurerm_dns_zone" "dns-zone" {
  name                = var.dns_name
  resource_group_name = var.rg_name
}