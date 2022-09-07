<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.69 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.69 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application_load_balancer"></a> [application\_load\_balancer](#module\_application\_load\_balancer) | git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/alb | v2.3.3 |
| <a name="module_ec2_autoscaling"></a> [ec2\_autoscaling](#module\_ec2\_autoscaling) | git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/ec2-autoscaling | v2.3.3 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ec2_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ec2_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.secretmanager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_security_group.alb_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.host-egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.host-ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_public_port"></a> [alb\_public\_port](#input\_alb\_public\_port) | The ELB Security group prot for http traffic. | `number` | `80` | no |
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | List of IPs allowed to access application over the external/public endpoint. | `list(string)` | n/a | yes |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | VPC CIDR block to allow on security groups for private instance | `string` | n/a | yes |
| <a name="input_docker_password"></a> [docker\_password](#input\_docker\_password) | The Dockerhub password will be fetch from aws secret manager | `string` | n/a | yes |
| <a name="input_docker_user_name"></a> [docker\_user\_name](#input\_docker\_user\_name) | The Dockerhub user name will be fetch from aws secret manager | `string` | n/a | yes |
| <a name="input_docker_version"></a> [docker\_version](#input\_docker\_version) | The Dockerhub repo image version to pull and run the container | `string` | n/a | yes |
| <a name="input_dockerhub_repo"></a> [dockerhub\_repo](#input\_dockerhub\_repo) | The Dockerhub repo name to pull and run the container | `string` | n/a | yes |
| <a name="input_host_sg_ingress_ports"></a> [host\_sg\_ingress\_ports](#input\_host\_sg\_ingress\_ports) | List of ports/protocols separated by a forward slash (/). | `list(string)` | <pre>[<br>  "22/tcp",<br>  "443/tcp",<br>  "80/tcp"<br>]</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance. | `map(any)` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The key name to use for the instance | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the Auto Scaling Group. | `string` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the Auto Scaling Group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Prefix used to create resource names. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | An object describing the AWS VPC network. | <pre>object({<br>    vpc_id            = string<br>    public_subnet_ids = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS deployment cccount profile name. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS default region to launch the instance (private, bastion and vpc. | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The application deployment stage. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The VPC Subnet ID to associate. | `string` | n/a | yes |
| <a name="input_tag_info"></a> [tag\_info](#input\_tag\_info) | A map of tags to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of target that you must specify when registering targets with this target group | `string` | n/a | yes |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | The size of the volume in gigabytes. | `string` | n/a | yes |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | The volume type. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp2). | `string` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block to add in EC2 security group | `list(any)` | n/a | yes |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | A list of subnet IDs to launch resources in. | `list(any)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->