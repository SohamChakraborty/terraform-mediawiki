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

data "aws_vpc" "selected" {
  filter {
    name = "tag:Environment"
    values = ["development"]
  }
}

module "mediawiki_security_group" {
    source                      = "terraform-aws-modules/security-group/aws"
    version                     = "~> 3.0"
    name                        = "security-group-${var.environment}-${var.role}"
    description                 = "Security group for mediawiki host"
    vpc_id                      = data.aws_vpc.selected.id 
    ingress_cidr_blocks         = ["0.0.0.0/0"]
    ingress_rules               = ["http-80-tcp", "ssh-tcp"]
    egress_rules                = ["all-all"]
    #computed_ingress_rules      = ["ssh-tcp"]
    #number_of_computed_ingress_rules = 1
    tags                        = {
                Environment     = var.environment
                Role            = var.role
    }
}

