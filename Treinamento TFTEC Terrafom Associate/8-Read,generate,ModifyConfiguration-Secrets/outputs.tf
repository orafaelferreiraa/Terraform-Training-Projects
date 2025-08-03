output "secret_value" {
  value     = module.vm-linux-01.secret_value
  sensitive = true
}

output "public_ip_address" {
  value = module.vm-linux-01.public_ip_address
}