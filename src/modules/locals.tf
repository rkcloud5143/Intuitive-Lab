locals {
  availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  bucket_name = "rk-intuitive-s3-private"
}