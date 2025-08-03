output "all_public_ips" {
  value = azurerm_public_ip.pip-tftec-loop-lnx2[*].ip_address
}
