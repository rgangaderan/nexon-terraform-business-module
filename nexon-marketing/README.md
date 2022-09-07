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
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application_load_balancer"></a> [application\_load\_balancer](#module\_application\_load\_balancer) | git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/alb | v2.3.4 |
| <a name="module_ecr-repository"></a> [ecr-repository](#module\_ecr-repository) | git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/ecr | v2.3.4 |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/ecs-service | v2.3.4 |
| <a name="module_rds"></a> [rds](#module\_rds) | git@github.com:rgangaderan/nexon-terraform-tech-module.git//aws/rds-instance | v2.3.4 |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository_policy.ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ssm_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.task_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.alb_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.rds_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_elb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.host-egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.address](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.db_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [null_resource.initial_dummy_image](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_ssm_parameter.db_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.db_username](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_ids"></a> [account\_ids](#input\_account\_ids) | AWS Account Ids that can pull the ECR Images | `list(any)` | n/a | yes |
| <a name="input_alb_public_port"></a> [alb\_public\_port](#input\_alb\_public\_port) | The ELB Security group prot for http traffic. | `number` | `80` | no |
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | List of IPs allowed to access application over the external/public endpoint. | `list(string)` | n/a | yes |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Assign a public IP address to the ENI (Fargate launch type only). | `bool` | n/a | yes |
| <a name="input_db"></a> [db](#input\_db) | Database related Variables. | <pre>object(<br>    {<br>      storage               = string<br>      engine                = string<br>      engine_version        = string<br>      instance_class        = string<br>      database_name         = string<br>      database_username_key = string<br>      database_password_key = string<br>      parameter_group_name  = string<br>      skip_snapshot         = string<br>      deletion_protection   = string<br>      db_port               = number<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_ecs_configuration"></a> [ecs\_configuration](#input\_ecs\_configuration) | The object describing the ecs configurations. | <pre>object(<br>    {<br>      general_configuration = object({<br>        cpu           = number<br>        memory        = number<br>        desired_count = number<br>        launch_type   = string<br><br>      })<br><br>      ports = object({<br>        container_port = number<br>        host_port      = number<br><br>      })<br><br><br>    }<br>  )</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment variables to pass to the container. This is a list of object. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Prefix used to create resource names. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | An object describing the AWS VPC network. | <pre>object({<br>    vpc_id            = string<br>    public_subnet_ids = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_private_cidr"></a> [private\_cidr](#input\_private\_cidr) | Private CIDR block to allow on security groups for RDS Instance | `list(any)` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Private subnet IDs associate with RDS Instance Subnet Group | `list(any)` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS deployment cccount profile name. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS default region to launch the instance (private, bastion and vpc. | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | The secrets to pass to the container. This is a list of object | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `[]` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | The application deployment stage. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet IDs associate with ECS Service. | `list(any)` | n/a | yes |
| <a name="input_tag_info"></a> [tag\_info](#input\_tag\_info) | A map of tags to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of target that you must specify when registering targets with this target group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repo_name"></a> [repo\_name](#output\_repo\_name) | Name of the ECR Repo |
| <a name="output_url"></a> [url](#output\_url) | URL of the ECR |
<!-- END_TF_DOCS -->