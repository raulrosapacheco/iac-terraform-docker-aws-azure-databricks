module "ec2_instances" {
  
  source = "./modules/ec2-instances"

  instance_count = 2
  ami_id         = "ami-0772d6acfbccb1275"
  instance_type  = "t3.micro"
  subnet_id      = "subnet-0dc03c070ddfc0cf5"
}

module "s3_bucket" {

  source = "./modules/s3-bucket"

  bucket_name = "raulrosa-aws-bucket-s3"
  tags        = {"Raul" = "Rosa"}
}
