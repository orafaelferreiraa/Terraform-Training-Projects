variable "sql_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group where the SQL Server will be created."
  type        = string
}

variable "location" {
  description = "The Azure Region where the SQL Server will be created."
  type        = string
}

variable "sql_version" {
  description = "The version of the SQL Server."
  type        = string
}

variable "sql_admin" {
  description = "The administrator login for the SQL Server."
  type        = string
  sensitive   = false
}

variable "sql_pass" {
  description = "The administrator password for the SQL Server."
  type        = string
  sensitive   = false
}
