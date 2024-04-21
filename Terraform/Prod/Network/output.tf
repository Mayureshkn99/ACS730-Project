output "public_subnet_id" {
  value = module.vpc-prod.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc-prod.private_subnet_id
}

output "route_table_id" {
  value = module.vpc-prod.route_table_id
}

output "vpc_id" {
  value = module.vpc-prod.vpc_id
}
