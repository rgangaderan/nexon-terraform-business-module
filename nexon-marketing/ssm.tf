###################################################################
# SSM parameter to store DB endpoint or host name and databese name
###################################################################

resource "aws_ssm_parameter" "db_name" {
  name  = "/${var.stage}/database/host/dbname"
  type  = "String"
  value = module.rds.db_name
}

resource "aws_ssm_parameter" "address" {
  name  = "	/${var.stage}/database/host/address"
  type  = "String"
  value = module.rds.address
}
