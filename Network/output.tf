output "public_subnet_id" {
  value = module.vpc-dev.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc-dev.private_subnet_id
}

output "route_table_id" {
  value = module.vpc-dev.route_table_id
}

output "vpc_id" {
  value = module.vpc-dev.vpc_id
}
