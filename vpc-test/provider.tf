terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.17.0"
    }
  }
  backend "s3" {
    bucket = "terraform-remote-state-267"
    key = "vpc-test-2"
    region = "us-east-1"
    use_lockfile = true 
    encrypt = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}