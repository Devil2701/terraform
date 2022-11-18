resource "aws_instance" "ubuntu" {

  ami           = "ami-097a2df4ac947655f"
  instance_type = "t2.micro"

  tags = {
    Name = "terra_instance"
  }
}