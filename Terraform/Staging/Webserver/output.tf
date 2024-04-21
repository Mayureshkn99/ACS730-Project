# Add output variables
output "public_webservers_ip_address" {
  value = module.webserver-staging.public_webservers_ip_address
}

output "private_webservers_ip_address" {
  value = module.webserver-staging.private_webservers_ip_address
}