output "sql_pass" {
  value     = azurerm_mssql_server.sql-server.administrator_login_password
  sensitive = false
}


output "sql_admin" {
  value     = azurerm_mssql_server.sql-server.administrator_login
  sensitive = false
}
