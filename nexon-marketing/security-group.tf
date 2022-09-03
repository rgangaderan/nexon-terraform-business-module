
resource "aws_security_group" "rds_instance" {
  # checkov:skip=CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
  # checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to an other resource"

  vpc_id      = var.network.vpc_id
  description = "elb public with allowed ports (443 or 80)"

  ingress {
    description = "elb public with allowed ports (443 or 80)"
    from_port   = var.db.db_port
    to_port     = var.db.db_port
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
