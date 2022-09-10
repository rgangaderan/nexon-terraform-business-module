<!-- BEGIN_TF_DOCS -->
# nexon-terraform-business-module

## Iteration 01.

### Manual Steps 
Application hosted on EC2 Autoscaling Group with AWS ClassicLoadBalancer.

1. SSH Keypare
mypuc.pem
https://docs.aws.amazon.com/ground-station/latest/ug/create-ec2-ssh-key-pair.html

2. S3 Bucket
aritifacts-nexon-app

This Application has a static web page and artifact stored in S3 bucket.

s3://aritifacts-nexon-app/index.html

We have Separate CI pipeline running in GitHub Action on 
https://github.com/rgangaderan/nexon-application-CICD/blob/main/.github/workflows/ci-static-webapp-elb.yml

The above workflow will copy the artifact (Index.html) to s3 bucket during the CI process and when we deploy this module. User_data will download the index.html to var/www/html and run the instance based on max nad min count defined in Autoscaling Group, it will also creating a Launch Template with all the information related to EC2

```
#!/bin/bash

# Update and install apache web server
sudo apt-get update && sudo apt-get install apache2 -y

# Instanll AWS CLI to access S3 Bucket for copy artifacts #
sudo apt install awscli -y
sudo -i

# Copy artifact for web application #

aws s3 cp s3://aritifacts-nexon-app/index.html /var/www/html/
```
![image](https://user-images.githubusercontent.com/41107404/189475619-e755855e-c75b-46c4-8cf8-e3badc0d0a5a.png)


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.69 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.69 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_autoscaling"></a> [ec2\_autoscaling](#module\_ec2\_autoscaling) | git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/ec2_autoscaling | v2.3.3 |
| <a name="module_elb"></a> [elb](#module\_elb) | git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/elb | v2.3.3 |
| <a name="module_elb_attachment"></a> [elb\_attachment](#module\_elb\_attachment) | git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/elb_attachment | v2.3.3 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ec2_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ec2_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.secretmanager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_security_group.elb_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_elb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.host-egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.host-ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs"></a> [access\_logs](#input\_access\_logs) | An access logs block | `map(string)` | `{}` | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | VPC CIDR block to allow on security groups for private instance | `string` | n/a | yes |
| <a name="input_connection_draining"></a> [connection\_draining](#input\_connection\_draining) | Boolean to enable connection draining | `bool` | `false` | no |
| <a name="input_connection_draining_timeout"></a> [connection\_draining\_timeout](#input\_connection\_draining\_timeout) | The time in seconds to allow for connections to drain | `number` | `300` | no |
| <a name="input_create_elb"></a> [create\_elb](#input\_create\_elb) | Create the elb or not | `bool` | `true` | no |
| <a name="input_cross_zone_load_balancing"></a> [cross\_zone\_load\_balancing](#input\_cross\_zone\_load\_balancing) | Enable cross-zone load balancing | `bool` | `true` | no |
| <a name="input_elb_name_prefix"></a> [elb\_name\_prefix](#input\_elb\_name\_prefix) | Creates a unique name beginning with the specified prefix (cannot be longer than 6 characters) | `string` | `"nexon"` | no |
| <a name="input_elb_public_port"></a> [elb\_public\_port](#input\_elb\_public\_port) | The ELB Security group prot for http traffic. | `number` | `80` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | A health check block | `map(string)` | <pre>{<br>  "healthy_threshold": 2,<br>  "interval": 30,<br>  "target": "HTTP:80/",<br>  "timeout": 3,<br>  "unhealthy_threshold": 2<br>}</pre> | no |
| <a name="input_host_sg_ingress_ports"></a> [host\_sg\_ingress\_ports](#input\_host\_sg\_ingress\_ports) | List of ports/protocols separated by a forward slash (/). | `list(string)` | <pre>[<br>  "22/tcp",<br>  "443/tcp",<br>  "80/tcp"<br>]</pre> | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | The time in seconds that the connection is allowed to be idle | `number` | `60` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance. | `map(any)` | n/a | yes |
| <a name="input_instances"></a> [instances](#input\_instances) | List of instances ID to place in the ELB pool | `list(string)` | `[]` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | If true, ELB will be an internal ELB | `bool` | `false` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The key name to use for the instance | `string` | n/a | yes |
| <a name="input_listener"></a> [listener](#input\_listener) | A list of listener blocks | `list(map(string))` | <pre>[<br>  {<br>    "instance_port": 80,<br>    "instance_protocol": "http",<br>    "lb_port": 80,<br>    "lb_protocol": "http"<br>  }<br>]</pre> | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the Auto Scaling Group. | `string` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the Auto Scaling Group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Prefix used to create resource names. | `string` | n/a | yes |
| <a name="input_number_of_instances"></a> [number\_of\_instances](#input\_number\_of\_instances) | Number of instances to attach to ELB | `number` | `0` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS deployment cccount profile name. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS default region to launch the instance (private, bastion and vpc. | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The application deployment stage. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The VPC Subnet ID to associate. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of public subnet IDs to attach with the ELB. | `list(string)` | n/a | yes |
| <a name="input_tag_info"></a> [tag\_info](#input\_tag\_info) | A map of tags to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | The size of the volume in gigabytes. | `string` | n/a | yes |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | The volume type. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp2). | `string` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block to add in EC2 security group | `list(any)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id for EC2 Security Group. | `string` | n/a | yes |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | A list of subnet IDs to launch resources in. | `list(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elb_arn"></a> [elb\_arn](#output\_elb\_arn) | The ARN of the ELB |
| <a name="output_elb_dns_name"></a> [elb\_dns\_name](#output\_elb\_dns\_name) | The DNS name of the ELB |
| <a name="output_elb_id"></a> [elb\_id](#output\_elb\_id) | The name of the ELB |
| <a name="output_elb_instances"></a> [elb\_instances](#output\_elb\_instances) | The list of instances in the ELB |
| <a name="output_elb_name"></a> [elb\_name](#output\_elb\_name) | The name of the ELB |
| <a name="output_elb_source_security_group_id"></a> [elb\_source\_security\_group\_id](#output\_elb\_source\_security\_group\_id) | The ID of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances |
| <a name="output_elb_zone_id"></a> [elb\_zone\_id](#output\_elb\_zone\_id) | The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record) |
<!-- END_TF_DOCS -->
