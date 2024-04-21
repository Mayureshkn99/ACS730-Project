# Add output variables
output "public_webservers_ip_address" {
  value = module.webserver-prod.public_webservers_ip_address
}

output "private_webservers_ip_address" {
  value = module.webserver-prod.private_webservers_ip_address
}