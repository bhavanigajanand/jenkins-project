# 1. This creates the digital key bits
resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. This sends the public part to AWS
resource "aws_key_pair" "deployer_key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_key.public_key_openssh
}

# 3. This saves the private part as a .pem file on your laptop
resource "local_file" "private_key" {
  content         = tls_private_key.rsa_key.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0400" # Sets secure permissions (Read-only)
}