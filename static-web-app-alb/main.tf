
################################################################################
# Application LoadBalancer
################################################################################
module "application_load_balancer" {
  source = "git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/alb?ref=v2.3.0"

  network     = var.network
  allowed_ips = var.allowed_ips
  tag_info    = var.tag_info
  name        = var.name
  stage       = var.stage
}

################################################################################
# EC2 Private
################################################################################

module "ec2" {
  source = "git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/ec2_private?ref=v2.3.0"

  image_id             = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  instance_count       = var.instance_count
  key_name             = var.key_name
  user_data            = file("user_data.sh")
  subnet_id            = var.subnet_id
  security_groups      = [aws_security_group.instances.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  stage                = var.stage
  name                 = var.name


  providers = {
    aws = aws
  }
}
