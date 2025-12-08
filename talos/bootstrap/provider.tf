terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.23.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.32.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.15.0"
    }
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

provider "kubernetes" {
  config_path    = "~/.kube/homelab"
  config_context = "admin@homelab"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/homelab"
  }
}

terraform {
  backend "s3" {
    key     = "homelab/proxmox/kubernetes/bootstrap/terraform.tfstate"
    bucket  = "pynenborg-home-terraform-eu-west-1"
    region  = "eu-west-1"
    encrypt = true
  }
}
