provider "aws" {
  region  = "us-east-2"  
}

resource "aws_instance" "tarefa1" {
  ami           = "ami-04a8291398335a9ac"  # AMI na AWS
  instance_type = "t3.micro"

  tags = {
    Name = "lab1-terraform"
  }
}