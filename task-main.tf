resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "terra_VPC"
  }
}

resource "aws_subnet" "prod-subnet-public-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-2c"
    tags= {
        Name = "prod-subnet-public-1"
    }
}
resource "aws_subnet" "prod-subnet-private-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2b"
    tags= {
        Name = "prod-subnet-private-1"
    }
}
resource "aws_internet_gateway" "prod-igw" {
    vpc_id = "${aws_vpc.main.id}"
    tags= {
        Name = "prod-igw"
    }
}
resource "aws_route_table" "prod-public-crt" {
    vpc_id = "${aws_vpc.main.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.prod-igw.id}" 
    }
    
    tags= {
        Name = "prod-public-crt"
    }
}
resource "aws_route_table_association" "prod-crta-public-subnet-1"{
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    route_table_id = "${aws_route_table.prod-public-crt.id}"
}
resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.main.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }
    //If you do not add this rule, you can not reach the NGIX  
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags= {
        Name = "ssh-allowed"
    }
}
resource "aws_instance" "myFirstInstance" {
  subnet_id= "${aws_subnet.prod-subnet-private-1.id}"  
  ami           = "ami-097a2df4ac947655f"
  key_name = "ohio-key"
  instance_type = "t3.large"
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
  tags= {
    Name = "EC2-userdata"
  }
  user_data = file("script.sh")
}
resource "aws_instance" "mysecomdInstance" {
  subnet_id= "${aws_subnet.prod-subnet-public-1.id}"  
  ami           = "ami-097a2df4ac947655f"
  key_name = "ohio-key"
  instance_type = "t3.large"
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
  tags= {
    Name = "EC2-userdata"
  }
  user_data = file("script.sh")
}

