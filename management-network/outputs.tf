output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR range of the VPC."
  value       = module.vpc.vpc_cidr_block
}

output "private_subnet_ids" {
  description = "A list of private subnet IDs created in the VPC."
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "A list of public subnet IDs created in the VPC."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_cidrs" {
  description = "A list of private subnet CIDRs created in the VPC."
  value       = module.vpc.private_subnet_cidrs
}

output "public_subnet_cidrs" {
  description = "A list of public subnet CIDRs created in the VPC."
  value       = module.vpc.public_subnet_cidrs
}

output "private_cidr" {
  description = "The network range used to create the private subnets in the VPC."
  value       = module.vpc.private_cidr
}

output "private_route_table_ids" {
  description = "A list of private route table IDs created in the VPC."
  value       = module.vpc.private_route_table_ids
}

output "public_route_table_ids" {
  description = "A list of public route table IDs created in the VPC."
  value       = module.vpc.public_route_table_ids
}

output "nat_public_ips" {
  description = "A list of public IPs associated with the NAT gateways created in the VPC."
  value       = module.vpc.nat_public_ips
}
