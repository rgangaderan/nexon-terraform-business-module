#################################################################
# SSM Parameter Store for fetch Database User name and password 
#################################################################

data "aws_ssm_parameter" "db_username" {
  name = var.db.database_username_key
}

data "aws_ssm_parameter" "db_password" {
  name = var.db.database_password_key
}
