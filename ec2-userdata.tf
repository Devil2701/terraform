

resource "aws_instance" "myFirstInstance" {
  ami           = "ami-097a2df4ac947655f"
  key_name = "ohio-key"
  instance_type = "t3.large"
  vpc_security_group_ids = ["sg-0f263ffb1b7037b69"]
  tags= {
    Name = "EC2-userdata"
  }
  user_data = file("script.sh")
}
