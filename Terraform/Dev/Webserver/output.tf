# Add output variables
output "public_webservers_ip_address" {
  value = module.webserver-dev.public_webservers_ip_address
}

output "private_webservers_ip_address" {
  value = module.webserver-dev.private_webservers_ip_address
}