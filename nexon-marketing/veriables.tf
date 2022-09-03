variable "profile" {
  type        = string
  description = "AWS deployment cccount profile name."
}
variable "region" {
  type        = string
  description = "AWS default region to launch the instance (private, bastion and vpc."
}

variable "stage" {
  description = "The application deployment stage."
  type        = string
  default     = "development"
  validation {
    condition     = contains(["development", "qa", "production", "staging"], var.stage)
    error_message = "Invalid stage name - Stage must be one of \"development\", \"qa\", \"production\", \"staging\"."
  }
}

variable "name" {
  description = "Prefix used to create resource names."
  type        = string
}

variable "db" {
  type = object(
    {
      storage              = string
      engine               = string
      engine_version       = string
      instance_class       = string
      database_name        = string
      database_username    = string
      database_password    = string
      parameter_group_name = string
      skip_snapshot        = string
      deletion_protection  = string
      db_port              = number
    }
  )

  description = "Database related Variables."
}

variable "private_cidr" {
  type        = list
  description = "Private CIDR block to allow on security groups for RDS Instance"
}


variable "private_subnet_ids" {
  type        = list
  description = "Private subnet IDs associate with RDS Instance Subnet Group"
}

variable "network" {
  description = "An object describing the AWS VPC network."
  type = object({
    vpc_id            = string
    public_subnet_ids = list(string)
  })
}

variable "tag_info" {
  type        = map(any)
  default     = {}
  description = " A map of tags to assign to the resource."
}
