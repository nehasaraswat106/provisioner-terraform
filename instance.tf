# Define an AWS Key Pair resource for 'anjalikey'
resource "aws_key_pair" "anjalikey" {
  key_name   = "nehakey"                          # Name of the key pair
  public_key = file("${path.module}/nehakey.pub") # Public key file for SSH access
}

# Define an AWS Key Pair resource for 'nehakey'
resource "aws_key_pair" "nehakey" {
  key_name   = "nehakey"                          # Name of the key pair
  public_key = file("${path.module}/nehakey.pub") # Public key file for SSH access
}

# Define an AWS EC2 Instance resource
resource "aws_instance" "anjali-inst" {
  ami                    = var.AMIS[var.REGION]          # Map of AMIs with region as the key
  instance_type          = "t2.micro"                    # Instance type
  availability_zone      = var.ZONE1                     # Availability zone
  key_name               = aws_key_pair.nehakey.key_name # Use 'nehakey' for this instance
  subnet_id              = var.SUBNET_ID                 # Subnet ID (must be in the same VPC as the security group)
  vpc_security_group_ids = ["sg-0c9ce67e5472ae021"]      # Security group ID

  tags = {
    Name    = "Dove-Instance" # Instance name tag
    project = "Dove"          # Project name tag
  }

  # File provisioner to upload a script
  provisioner "file" {
    source      = "${path.module}/web.sh" # Local path of the script (relative to module)
    destination = "/tmp/web.sh"           # Destination path on the instance
  }

  # Remote execution provisioner to run the script
  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh", # Make the script executable
      "sudo /tmp/web.sh"       # Execute the script with sudo privileges
    ]
  }

  # Connection details for provisioners
  connection {
    type        = "ssh"                          # Protocol for connection
    user        = var.USER                       # User for SSH (e.g., "ec2-user" for Amazon Linux or "ubuntu" for Ubuntu)
    private_key = file("${path.module}/nehakey") # Path to the private key file
    host        = self.public_ip                 # Use the public IP of the instance for SSH
  }
}
