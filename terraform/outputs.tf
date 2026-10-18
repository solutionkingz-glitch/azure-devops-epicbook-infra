output "app_public_ip" {
  description = "Frontend VM public IP (browser entry point)"
  value       = azurerm_public_ip.frontend.ip_address
}

output "backend_ansible_host" {
  description = "Address Ansible uses to SSH to the backend VM"
  value       = azurerm_public_ip.backend.ip_address
}

output "backend_private_ip" {
  description = "Private IP Nginx uses to reach EpicBook"
  value       = azurerm_network_interface.backend.private_ip_address
}

output "mysql_fqdn" {
  description = "Private MySQL Flexible Server hostname"
  value       = azurerm_mysql_flexible_server.main.fqdn
}
