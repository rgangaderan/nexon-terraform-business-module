
resource "aws_security_group" "ecs" {
  # checkov:skip=CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
  # checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to an other resource"
  vpc_id      = var.network.vpc_id
  description = "elb public with allowed ports (443 or 80)"
}

resource "aws_security_group_rule" "allow_elb" {
  description = "The elb security group will added to ecs security-group as source for accessing private ecs tasks from public elb."

  type                     = "ingress"
  from_port                = "80"
  to_port                  = "80"
  protocol                 = "-1"
  source_security_group_id = aws_security_group.alb_public.id

  security_group_id = aws_security_group.ecs.id
}

resource "aws_security_group_rule" "host-egress" {
  description = "The security group egress rule."

  type      = "egress"
  from_port = "0"
  to_port   = "0"
  protocol  = "-1"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.ecs.id
}

resource "aws_security_group" "alb_public" {
  # checkov:skip=CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
  # checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to an other resource"

  vpc_id      = var.network.vpc_id
  description = "elb public with allowed ports (443 or 80)"

  ingress {
    description = "elb public with allowed ports (443 or 80)"
    from_port   = var.alb_public_port
    to_port     = var.alb_public_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    description      = "egree rule for elb security group"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "rds_instance" {
  # checkov:skip=CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
  # checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to an other resource"

  vpc_id      = var.network.vpc_id
  description = "RDS Isntacne access on port 3306"
  ingress {
    description = "elb public with allowed ports (443 or 80)"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.private_cidr

  }

  egress {
    description      = "egree rule for elb security group"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
