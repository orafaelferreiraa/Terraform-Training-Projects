variable "sql_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "sql_version" {
  description = "The version of the SQL Server."
  type        = string
}

variable "sql_admin" {
  description = "The administrator login for the SQL Server."
  type        = string
  sensitive   = true
}

variable "sql_pass" {
  description = "The administrator password for the SQL Server."
  type        = string
  sensitive   = true
}
