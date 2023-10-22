terraform {
  # uncomment if you would like to use state management using S3 and DynamoDB
  #   backend "s3" {
  #     bucket         = "intuitive-dev-tf-state-backend-ci-cd"
  #     key            = "tf-infra/terraform.tfstate"
  #     region         = "us-east-1"
  #     dynamodb_table = "terraform-state-locking"
  #     encrypt        = true
  #   }

  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc-infra" {
  source               = "./modules/vpc"
  vpc_cidr             = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}

module "s3-bucket" {
  source      = "./modules/s3"
  bucket_name = local.bucket_name
}

module "ec2-compute" {
  source     = "./modules/ec2"
  count      = 2
  depends_on = [module.vpc-infra]

}
