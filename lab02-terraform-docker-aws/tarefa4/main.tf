module "ec2_instances" {
  
  source = "./modules/ec2-instances"

  instance_count = 2
  ami_id         = "ami-04a8291398335a9ac"
  instance_type  = "t3.micro"
  subnet_id      = "subnet-0dc03c070ddfc0cf5"
}

