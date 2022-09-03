################################################################################
# RDS Instance
################################################################################
module "rds" {
  source = "/Users/rajee/Desktop/web-app-docker/rds-instance"

  db                    = var.db
  security_group        = [aws_security_group.rds_instance.id]
  name                  = var.name
  stage                 = var.stage
  private_subnet_ids    = var.private_subnet_ids

  providers = {
    aws = aws
  }
}
