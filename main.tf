provider "local" {
  
}
provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_vpc" "foo" {
  cidr_block = "10.0.0.0/16"
}
resource "local_file" "foo" {
    filename = "${path.module}/foo.txt"
    content     = "Hello World!"

}

data "local_file" "bar" {
    filename = "${path.module}/bar.txt"
}
output "file_bar" {
  value = data.local_file.bar
} 
