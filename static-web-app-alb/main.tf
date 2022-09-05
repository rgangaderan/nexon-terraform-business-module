################################################################################
#local data for user_date
################################################################################
locals {
  user_data = templatefile("${path.module}/user_data.tpl", {
    dockerhub_repo      = var.dockerhub_repo
    version             = var.docker_version
    user_secret_key     = var.docker_user_name
    password_secret_key = var.docker_password
    region              = var.region
  })
}

################################################################################
# Application LoadBalancer
################################################################################
module "application_load_balancer" {

  source = "git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/alb?ref=v2.3.3"

  network     = var.network
  allowed_ips = var.allowed_ips
  tag_info    = var.tag_info
  name        = var.name
  stage       = var.stage
  type        = var.type

  security_groups = [aws_security_group.alb_public.id]

}

################################################################################
# EC2 Autoscaling Group
################################################################################

module "ec2_autoscaling" {

  source = "git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/ec2-autoscaling?ref=v2.3.3"


  image_id             = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  key_name             = var.key_name
  user_data            = local.user_data
  volume_size          = var.volume_size
  volume_type          = var.volume_type
  subnet_id            = var.subnet_id
  security_groups      = [aws_security_group.instances.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  stage                = var.stage
  name                 = var.name
  vpc_zone_identifier  = var.vpc_zone_identifier
  max_size             = var.max_size
  min_size             = var.min_size
  target_group_arns    = [module.application_load_balancer.target_group_arns]

  depends_on = [module.application_load_balancer]

  providers = {
    aws = aws
  }
}
