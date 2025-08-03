resource "azurerm_mssql_server" "sql-server" {
  name                         = var.sql_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.sql_admin
  administrator_login_password = var.sql_pass
}
