

variable "key_name" { 
    description = " SSH keys to connect to ec2 instance" 
    default     =  "ohio-key" 
}

variable "instance_type" { 
    description = "instance type for ec2" 
    default     =  "t3.micro" 
}

variable "security_group" { 
    description = "Name of security group" 
    default     = "my-SG_terraform" 
}

variable "tag_name" { 
    description = "Tag Name of for Ec2 instance" 
    default     = "my-ec2-instance_terra" 
} 
variable "ami_id" { 
    description = "AMI for Ubuntu Ec2 instance" 
    default     = "ami-097a2df4ac947655f" 
}