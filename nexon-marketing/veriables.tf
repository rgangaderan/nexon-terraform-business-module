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
      storage               = string
      engine                = string
      engine_version        = string
      instance_class        = string
      database_name         = string
      database_username_key = string
      database_password_key = string
      parameter_group_name  = string
      skip_snapshot         = string
      deletion_protection   = string
      db_port               = number
    }
  )

  description = "Database related Variables."
}

variable "private_cidr" {
  type        = list(any)
  description = "Private CIDR block to allow on security groups for RDS Instance"
}


variable "private_subnet_ids" {
  type        = list(any)
  description = "Private subnet IDs associate with RDS Instance Subnet Group"
}

variable "subnet_ids" {
  type        = list(any)
  description = "Subnet IDs associate with ECS Service."
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



#############################
# Variables for ECS
#############################

variable "ecs_configuration" {
  description = "The object describing the ecs configurations."
  type = object(
    {
      general_configuration = object({
        cpu           = number
        memory        = number
        desired_count = number
        launch_type   = string

      })

      ports = object({
        container_port = number
        host_port      = number

      })


    }
  )
}

variable "environment" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "The environment variables to pass to the container. This is a list of object."
  default     = []
}

variable "secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))
  description = "The secrets to pass to the container. This is a list of object"
  default     = []
}


variable "assign_public_ip" {
  type        = bool
  description = "Assign a public IP address to the ENI (Fargate launch type only)."
}

variable "account_ids" {
  type        = list(any)
  description = "AWS Account Ids that can pull the ECR Images"
}


##########################
# Application LoadBlancer
##########################

variable "allowed_ips" {
  description = "List of IPs allowed to access application over the external/public endpoint."
  type        = list(string)
}

variable "alb_public_port" {
  type        = number
  default     = 80
  description = "The ELB Security group prot for http traffic."
}


variable "type" {
  type        = string
  description = "Type of target that you must specify when registering targets with this target group"
}
