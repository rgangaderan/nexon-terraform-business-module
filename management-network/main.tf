################################################################################
# VPC Network
################################################################################
module "vpc" {
  source = "git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/vpc?ref=v2.1.2"

  cidr               = var.cidr
  cidr_num_bits      = var.cidr_num_bits
  max_azs            = var.max_azs
  az_limit           = var.az_limit
  single_nat_gateway = var.single_nat_gateway
  stage              = var.stage
  name               = var.name
  region             = var.region
  tag_info           = var.tag_info

  providers = {
    aws = aws
  }
}
