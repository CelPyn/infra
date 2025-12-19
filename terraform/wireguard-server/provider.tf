terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }

    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    key     = "wireguard-server/terraform.tfstate"
    bucket  = "pynenborg-home-terraform-eu-west-1"
    region  = "eu-west-1"
    encrypt = true
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}
