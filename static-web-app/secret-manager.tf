# resource "tls_private_key" "ssh_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "generated_key" {
#   key_name   = var.key_name
#   public_key = tls_private_key.ssh_key.public_key_openssh

#   provisioner "local-exec" { # Delete any existing pem keys in local directory !!
#     command = "rm -f *.pem"
#   }
#   provisioner "local-exec" { # Create pem key on your local Terraform directory!!
#     command = "echo '${tls_private_key.ssh_key.private_key_pem}' > ./${var.key_name}.pem"
#   }
#   provisioner "local-exec" { # Change permission on private key!!
#     command = "chmod 400 ./${var.key_name}.pem"
#   }
# }
# resource "aws_secretsmanager_secret" "secret_manager_name" {
#   count = 2
#   name  = "${element(var.secret_name, count.index)}-${var.stage}"
# }

# resource "aws_secretsmanager_secret_version" "secret_key_private" {
#   secret_id     = aws_secretsmanager_secret.secret_manager_name[0].id
#   secret_string = tls_private_key.ssh_key.private_key_pem
# }

# resource "aws_secretsmanager_secret_version" "secret_key_public" {
#   secret_id     = aws_secretsmanager_secret.secret_manager_name[1].id
#   secret_string = tls_private_key.ssh_key.public_key_pem
# }
