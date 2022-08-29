variable "profile" {
  type        = string
  description = "AWS deployment cccount profile name."
}
variable "region" {
  type        = string
  description = "AWS default region to launch the instance (private, bastion and vpc."
}

variable "instance_type" {
  type        = map(any)
  description = "The type of the instance."
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 Instances to be launched."
}

variable "iam_instance_profile" {
  type        = string
  default     = ""
  description = "The IAM Instance Profile to launch the instance with."
}

variable "name" {
  description = "Prefix used to create resource names."
  type        = string
}

variable "key_name" {
  type        = string
  description = "The key name to use for the instance"
}

variable "stage" {
  description = "The application deployment stage."
  type        = string
  validation {
    condition     = contains(["development", "qa", "production", "staging"], var.stage)
    error_message = "Invalid stage name - Stage must be one of \"development\", \"qa\", \"production\", \"staging\"."
  }
}

variable "cidr" {
  type        = string
  description = "VPC CIDR block to allow on security groups for private instance"
}


variable "vpc_cidr_block" {
  type        = list(any)
  description = "CIDR block to add in EC2 security group"
}

variable "volume_type" {
  type        = string
  description = "The volume type. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp2)."
}

variable "subnet_id" {
  type        = string
  description = "The VPC Subnet ID to associate."
}


##########################
# Application LoadBlancer
##########################

variable "network" {
  description = "An object describing the AWS VPC network."
  type = object({
    vpc_id            = string
    public_subnet_ids = list(string)
  })
}

variable "allowed_ips" {
  description = "List of IPs allowed to access application over the external/public endpoint."
  type        = list(string)
}

variable "tag_info" {
  type        = map(any)
  default     = {}
  description = " A map of tags to assign to the resource."
}

variable "alb_public_port" {
  type        = number
  default     = 80
  description = "The ELB Security group prot for http traffic."
}

variable "host_sg_ingress_ports" {
  type        = list(string)
  description = "List of ports/protocols separated by a forward slash (/)."
  default = [
    "22/tcp",
    "443/tcp",
    "80/tcp"
  ]
}
