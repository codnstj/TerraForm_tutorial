terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "chaewoon"
  region  = "ap-northeast-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-02de72c5dc79358c9"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
