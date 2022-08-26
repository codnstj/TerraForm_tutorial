terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.15.1"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "chaewoon"
  region = "ap.northeast.2"
}

data "aws_ecs_container_definition" "ecs-mongo" {
  task_definition = aws_ecs_task_definition.mongo.id
  container_name  = "mongodb"
}   