terraform {
  required_version  = ">=0.12.13"
  backend "s3" {}
}

provider "aws" {
    region                  = "eu-west-2"
    shared_credentials_file = "/home/soham/.aws/credentials"
    profile                 = "soham-pythian-sandbox"
    version                 = "2.69"
}

module "vpc" {
    source                  = "terraform-aws-modules/vpc/aws"
    version                 = "2.40.0"
    name                    = "${var.environment}-primary-vpc"
    cidr                    = var.cidr
    azs                     = var.azs
    private_subnets         = var.private_subnets
    public_subnets          = var.public_subnets
    enable_dns_support      = true
    enable_dns_hostnames    = true
    enable_nat_gateway      = false
    tags = {
      Environment = var.environment
      }
  // This is from https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/main.tf#L354
    public_subnet_tags = {
      Tier  = "public"
    }
    private_subnet_tags = {
      Tier  = "private"
    }
  }

