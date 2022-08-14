locals {
  name_prefix = "${var.name}_${var.stage}"

}
resource "aws_iam_role" "ec2_iam_role" {
  name = "${local.name_prefix}_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = local.name_prefix
  }
}

resource "aws_iam_role_policy" "secretmanager_policy" {
  name = "${local.name_prefix}_policy"
  role = aws_iam_role.ec2_iam_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:ListAccessPointsForObjectLambda",
                "s3:GetObject",
                "s3:ListBucketMultipartUploads",
                "s3:ListAllMyBuckets",
                "s3:ListBucket"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = local.name_prefix
  role = aws_iam_role.ec2_iam_role.name
}
