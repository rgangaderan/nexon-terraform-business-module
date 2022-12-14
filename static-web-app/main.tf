################################################################################
# EC2 Autoscaling Group
################################################################################

module "ec2_autoscaling" {

  source = "git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/ec2-autoscaling?ref=v2.3.4"


  image_id             = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  key_name             = var.key_name
  user_data            = file("user_data.sh")
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
  load_balancers       = [module.elb.elb_name]

  depends_on = [module.elb]
}

################################################################################
# Classic Load Balancer
################################################################################

module "elb" {

  source = "git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/elb?ref=v2.3.4"

  create_elb = var.create_elb

  name            = var.name
  stage           = var.stage
  subnets         = var.subnets
  security_groups = [aws_security_group.elb_public.id]
  internal        = var.internal


  cross_zone_load_balancing   = var.cross_zone_load_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout

  listener     = var.listener
  access_logs  = var.access_logs
  health_check = var.health_check

  tags = var.tag_info
}

################################################################################
# Classic Load Balancer Attachment
################################################################################

module "elb_attachment" {

  source = "git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/elb-attachment?ref=v2.3.4"

  create_attachment = var.create_elb

  number_of_instances = var.number_of_instances

  elb       = module.elb.elb_id
  instances = var.instances
}
