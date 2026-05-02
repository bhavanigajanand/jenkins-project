variable "instance_name" {
  description = "The Name tag for your EC2 instance"
  type        = string
  default     = "cicd-jenkins-29-april"
}

variable "key_name" {
  description = "The name of the key pair to create"
  type        = string
  default     = "cicd-jenkins-29-april"
}

variable "aws_region" {
  description = "Target AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Amazon Linux 2023 kernel-6.1 AMI"
  type        = string
  default     = "ami-098e39bafa7e7303d"
}

variable "instance_type" {
  description = "Size of the server"
  type        = string
  default     = "t3.medium"
}