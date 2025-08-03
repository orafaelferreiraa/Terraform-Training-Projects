output "secret_value" {
  value     = data.azurerm_key_vault_secret.kv-tftec-secret.value
  sensitive = true
}

output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}