data "aws_caller_indentity" "current" {}

data "aws_vpc" "this"{
    id = var.vpc_id
}
data "aws_subnet" "public1"{
    id = var.public_subnet1
}
data "aws_subnet" "public2"{
    id = var.public_subnet2
}
data "aws_subnet" "public3"{
    id = var.public_subnet3
}
data "aws_subnet" "public4"{
    id = var.public_subnet4
}
data "aws_security_group" "this"{
    id = var.sg_id
}