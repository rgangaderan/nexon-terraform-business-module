provider "aws" {
  default_tags {
    tags = {
      Terraform = "true"
    }
  }

  region  = var.region
  profile = var.profile

}

provider "tls" {}
