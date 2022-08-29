resource "aws_lb_target_group_attachment" "instance" {
  for_each         = { for k, instance in flatten(module.ec2.instance_ids) : k => instance }
  target_group_arn = module.application_load_balancer.target_group_arns
  target_id        = each.value
  port             = 80
}
