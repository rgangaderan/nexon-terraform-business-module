variable "aws_profile" {
  type        = string
  description = "The assume role profile for AWS Deployment."
}

variable "region" {
  type        = string
  description = "AWS Deployment Region"
}

variable "cidr" {
  description = "The CIDR of the VPC."
  type        = string
}

variable "max_azs" {
  description = <<EOF
The number of AZs you want to use in the VPC. Only values less than 'az_limit' and the number of available Zones in the Region are honored.
The number of the configured AZs will always be the lesser of the 3 values."
EOF

  type    = number
  default = 3
}

variable "az_limit" {
  description = <<EOF
The absolute limit for Availability Zones. The default is ok for most cases.
The variable is only here for future use (and for us-east-1).
EOF

  type    = number
  default = 6
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"

  type    = bool
  default = true
}

variable "name" {
  description = "The name of the ECR repository to manage."
  type        = string
  default     = "nexon"
}

variable "cidr_num_bits" {
  description = "Cidr num bits to create subnets."
  type        = number
  default     = 6
}

variable "stage" {
  description = "The application deployment stage."
  type        = string
  validation {
    condition     = contains(["development", "qa", "production", "staging"], var.stage)
    error_message = "Invalid stage name - Stage must be one of \"development\", \"qa\", \"production\", \"staging\"."
  }
}

variable "vpc_tag_info" {
  type        = map(any)
  description = "A map of tags to assign to the resource"
}
