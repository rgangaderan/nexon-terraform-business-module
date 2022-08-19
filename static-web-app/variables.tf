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

variable "name" {
  description = "Prefix used to create resource names."
  type        = string
}
#
#variable "secret_name" {
#  type        = list(any)
#  description = "Human readable name of the new secret."
#}

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

variable "vpc_id" {
  type        = string
  description = "VPC id for EC2 Security Group."
}

variable "cidr" {
  type        = string
  description = "VPC CIDR block to allow on security groups for private instance"
}

variable "volume_size" {
  type        = string
  description = "The size of the volume in gigabytes."
}

variable "volume_type" {
  type        = string
  description = "The volume type. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp2)."
}

variable "subnet_id" {
  type        = string
  description = "The VPC Subnet ID to associate."
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

variable "elb_public_port" {
  type        = number
  default     = 80
  description = "The ELB Security group prot for http traffic."
}


variable "vpc_zone_identifier" {
  type        = list(any)
  description = "A list of subnet IDs to launch resources in."
}

variable "max_size" {
  type        = string
  description = "The maximum size of the Auto Scaling Group."
}

variable "min_size" {
  type        = string
  description = "The minimum size of the Auto Scaling Group."
}

##################
# ELB
##################

variable "subnets" {
  description = "A list of public subnet IDs to attach with the ELB."
  type        = list(string)
}

variable "internal" {
  description = "If true, ELB will be an internal ELB"
  type        = bool
  default     = false
}

variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  type        = number
  default     = 60
}

variable "connection_draining" {
  description = "Boolean to enable connection draining"
  type        = bool
  default     = false
}

variable "connection_draining_timeout" {
  description = "The time in seconds to allow for connections to drain"
  type        = number
  default     = 300
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "listener" {
  description = "A list of listener blocks"
  type        = list(map(string))
  default = [{
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }]
}

variable "access_logs" {
  description = "An access logs block"
  type        = map(string)
  default     = {}
}

variable "health_check" {
  description = "A health check block"
  type        = map(string)
  default = {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
}

variable "number_of_instances" {
  description = "Number of instances to attach to ELB"
  type        = number
  default     = 0
}

variable "instances" {
  description = "List of instances ID to place in the ELB pool"
  type        = list(string)
  default     = []
}

variable "create_elb" {
  description = "Create the elb or not"
  type        = bool
  default     = true
}

variable "elb_name_prefix" {
  type        = string
  default     = "nexon"
  description = "Creates a unique name beginning with the specified prefix (cannot be longer than 6 characters)"
}

variable "vpc_cidr_block" {
  type        = list(any)
  description = "CIDR block to add in EC2 security group"
}

variable "tag_info" {
  type        = map(any)
  default     = {}
  description = " A map of tags to assign to the resource."
}
