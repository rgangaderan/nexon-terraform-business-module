###################################################################
# SSM parameter to store DB endpoint or host name and databese name
###################################################################

resource "aws_ssm_parameter" "db_name" {
  # checkov:skip=CKV2_AWS_34: "AWS SSM Parameter should be Encrypted"
  name  = "/${var.stage}/database/host/dbname"
  type  = "String"
  value = module.rds.db_name
}

resource "aws_ssm_parameter" "address" {
  # checkov:skip=CKV2_AWS_34: "AWS SSM Parameter should be Encrypted"
  name  = "/${var.stage}/database/host/address"
  type  = "String"
  value = module.rds.address
}
