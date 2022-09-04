################################################################################
# RDS Instance
################################################################################
# module "rds" {
#   source = "/Users/rajee/Desktop/nexon-new/nexon-terraform-tech-module/aws/rds-instance"

#   db                 = var.db
#   security_group     = [aws_security_group.rds_instance.id]
#   name               = var.name
#   stage              = var.stage
#   private_subnet_ids = var.private_subnet_ids
#   database_username  = data.aws_ssm_parameter.db_username.value
#   database_password  = data.aws_ssm_parameter.db_password.value

# }

################################################################################
# ECR Repository
################################################################################
module "ecr-repository" {
  source = "/Users/rajee/Desktop/nexon-new/nexon-terraform-tech-module/aws/ecr"

  name  = var.name
  stage = var.stage
}

################################################################################
# ECS Configuration including ECS Cluster, ECS Service and Task Definition
################################################################################
module "ecs" {
  source            = "/Users/rajee/Desktop/nexon-new/nexon-terraform-tech-module/aws/ecs-service"
  ecs_configuration = var.ecs_configuration
  name              = var.name
  stage             = var.stage
  image             = "${module.ecr-repository.url}:latest"
  subnet_ids        = var.subnet_ids
  assign_public_ip  = var.assign_public_ip
  security_groups   = [aws_security_group.ecs.id]
  target_group_arn  = module.application_load_balancer.target_group_arns

  ecs_task_execution_role = aws_iam_role.ecs_task_execution_role.arn

  task_role_arn = aws_iam_role.ecs_task_role.arn

  depends_on = [null_resource.initial_dummy_image]

  # environment_variable = var.environment_variable


}

################################################################################
# Application LoadBalancer
################################################################################
module "application_load_balancer" {

  source = "/Users/rajee/Desktop/nexon-new/nexon-terraform-tech-module/aws/alb" #"git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/alb?ref=v2.2.0"

  network     = var.network
  allowed_ips = var.allowed_ips
  tag_info    = var.tag_info
  name        = var.name
  stage       = var.stage
  type        = var.type

  security_groups = [aws_security_group.alb_public.id]
}

########################################################################################
# Null Resource to create a Dummy Image and push to ECR to avoide ecs deployments errors
# real deployments will be done with CICD pipelines
########################################################################################
resource "null_resource" "initial_dummy_image" {
  provisioner "local-exec" {
    command = "${path.module}/dummy-image.sh"

    environment = {
      REPOSITORY_URI = module.ecr-repository.url
      PROFILE        = var.profile
    }

    interpreter = [
      "bash",
      "-c"
    ]
  }
}
