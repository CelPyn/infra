terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.77"
    }
  }
  backend "s3" {
    key     = "bluesky/terraform.tfstate"
    bucket  = "pynenborg-home-terraform-eu-west-1"
    region  = "eu-west-1"
    encrypt = true
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "global-resources"
}
