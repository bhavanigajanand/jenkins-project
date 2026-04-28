resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  # Connects the key we generated in key_pair.tf
  key_name = aws_key_pair.deployer_key.key_name

  # Connects the security group from security.tf
  vpc_security_group_ids = [aws_security_group.project_sg.id]

  tags = {
    # This uses the name you set in variables.tf
    Name = var.instance_name
  }
}