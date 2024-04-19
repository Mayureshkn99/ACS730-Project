output "public_subnet_id" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnets[*].id
}

output "route_table_id" {
  value = aws_route_table.public_rt.id
}

output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}
