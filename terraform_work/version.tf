provider "aws" {
  region = "ap-northeast-2"
  profile = "default"
}

terraform {
  backend "remote" {
    organization = "codns"
    workspaces {
      name = "terraform_work"
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