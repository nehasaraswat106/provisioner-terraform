variable "REGION" {
  description = "AWS region where resources will be created"
  default     = "us-east-1"
}

variable "ZONE1" {
  description = "The availability zone for the EC2 instance"
  default     = "us-east-1a"
}

variable "AMIS" {
  description = "Map of regions to their respective AMI IDs"
  type        = map(string)
  default = {
    us-east-1 = "ami-0453ec754f44f9a4a"
  }
}

variable "USER" {
  description = "Default username for SSH connections to the instance"
  default     = "ec2-user"
}

variable "SUBNET_ID" {
  default = "subnet-0e34570fb2e0368b6" # Replace this with your actual subnet ID
}
