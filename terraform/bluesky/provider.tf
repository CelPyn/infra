provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "global-resources"
}

terraform {
  backend "s3" {
    key     = "bluesky/terraform.tfstate"
    bucket  = "pynenborg-home-terraform-eu-west-1"
    region  = "eu-west-1"
    encrypt = true
  }
}
