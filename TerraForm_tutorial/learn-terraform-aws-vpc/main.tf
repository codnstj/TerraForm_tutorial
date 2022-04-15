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
data "aws_availability_zones" "available"{}
data "aws_ami" "ubuntu" {}

resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags = {
    "Name" = "terraform-vpc"
  }
}

resource "aws_default_route_table" "terraform-vpc"{
  default_route_table_id = "${aws_vpc.terraform-vpc.default_route_table_id}"
  tags {
    Name = "Public_route"
  }
}

resource "aws_subnet" "pub-1"{
  vpc_id = "${aws_vpc.terraform-vpc.id}"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags = {
      Name = "public-az-1"
  }    
}
resource "aws_subnet" "pub2"{
  vpc_id = "${aws_vpc.terraform-vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags = {
     Name = "public-az-2"
  }    
}

resource "aws_subnet" "priv1"{
    vpc_id ="${aws_vpc.terraform-vpc.id}"
    cidr_block = "10.0.2.0/24"
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
    tags = {
       Name = "private-az-1"
    }
}
resource "aws_subnet" "priv2"{
    vpc_id ="${aws_vpc.terraform-vpc.id}"
    cidr_block = "10.0.3.0/24"
    availability_zone = "${data.aws_availability_zones.available.names[1]}"
    tags = {
       Name = "private-az-2"
    }
}

resource "aws_internet_gateway" "terraform-vpc-igw"{
  vpc_id = "${aws.vpc.terraform-vpc.id}"
  tags = {
    "Name" = "terraform-igw"
  }
}

resource "aws_route" "internet-access"{
  route_table_id = "${aws_vpc.terraform-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internetgateway.terraform-vpc.id}"
}

resource "aws_eip" "terraform-vpc-eip" {
  vpc = true
  depends_on = ["aws_internet_gateway.terraform-vpc-igw"]
}
resource "aws_nat_gateway" "terraform-vpc-ngw" {
  allocation_id = aws_eip.terraform-vpc-eip.id
  tags = {
    "Name" = "igw"
  }
}
resource "aws_route" "internet_access" {
  route_table_id = "${aws_vpc.terraform-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.terraform-vpc-igw.id}"
}