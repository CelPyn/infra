terraform {
  required_version = "~> 1.0"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/homelab"
  config_context = "admin@homelab"
}

terraform {
  backend "s3" {
    key     = "homelab/proxmox/kubernetes/secrets/terraform.tfstate"
    bucket  = "pynenborg-home-terraform-eu-west-1"
    region  = "eu-west-1"
    encrypt = true
  }
}
