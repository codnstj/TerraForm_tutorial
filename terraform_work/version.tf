provider "aws" {
  region = "ap-northeast-2"
  profile = "default"  
}

terraform {
  backend "remote" {
    organization = "codns"
    hostname = "terraform.io"
    workspaces {
      name = "TerraForm_tutorial"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}