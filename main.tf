provider "local" {
  # Configuration options
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