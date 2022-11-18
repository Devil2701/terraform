# create a resource for ec2 instance 
resource "aws_instance" "TFuser1_os1" {
ami = "ami-0d5bf08bc8017c83b"
instance_type ="t2.micro"
tags = {
  Name = "ec2-with-ebs"
 } 
}

#create a resource from EBS volume in same AZ as os1
resource "aws_ebs_volume" "TFebs1"{
 availability_zone = aws_instance.TFuser1_os1.availability_zone 
 size = 1
 tags = {
  Name = "Extra_EBS"
 }
}

#attach volume
resource "aws_volume_attachment" "attach_ebs_1"{
device_name = "/dev/sdh"
volume_id = aws_ebs_volume.TFebs1.id
instance_id =aws_instance.TFuser1_os1.id
}