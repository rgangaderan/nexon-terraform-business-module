provider "aws" {
  default_tags {
    tags = {
      Terraform = "true"
    }
  }

  region  = var.region
  profile = var.aws_profile
  assume_role {
    role_arn = var.deployment_role
  }
}
