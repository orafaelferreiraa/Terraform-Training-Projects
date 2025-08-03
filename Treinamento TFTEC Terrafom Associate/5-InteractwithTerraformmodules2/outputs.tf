output "sql_admin" {
  value     = module.sql_server_module.sql_admin
  sensitive = true
}


output "sql_pass" {
  value     = module.sql_server_module.sql_pass
  sensitive = true
}
