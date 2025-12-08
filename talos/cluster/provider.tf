terraform {
  required_providers {
    talos = {
      source  = "siderolabs/talos"
      version = "~> 0.0"
    }
  }
}

provider "talos" {}

terraform {
  backend "s3" {
    key     = "homelab/proxmox/kubernetes/cluster/terraform.tfstate"
    bucket  = "pynenborg-home-terraform-eu-west-1"
    region  = "eu-west-1"
    encrypt = true
  }
}
