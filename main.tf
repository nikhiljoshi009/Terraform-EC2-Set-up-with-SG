resource "aws_instance" "ec2_example_east1" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  tags = {
    Name = "Terraform EC2-1"
  }
  security_groups = [aws_security_group.web_sg.name]
  key_name        = "demo"
}

resource "aws_instance" "ec2_example_east2" {

  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  tags = {
    Name = "Terraform EC2-2"
  }
  security_groups = [aws_security_group.web_sg.name]
  key_name        = "demo"
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow inbound traffic on ports 22 and 80"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows SSH from anywhere, consider limiting this
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allows all outbound traffic
  }
}

resource "aws_key_pair" "demo" {
  key_name   = "demo"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbvAUXrxpArMpwBcZR8TAcIMtIJCjC4fYgTtm2bKPUmDz1HlmZY1p2n3s0VJkyGo/rggTrMtAuFkBR8MKH6zNRrhK4rbi/uurwS0ih79Qay7fwFeQ2bRamkaniYWVxYdKU4lhf9GGkUW1Op9Knbj3FKDRkv9DxDr348q/GyCdAjwQOlQhSF/cGEiX2o7FAfhmjwHYlH3eUUnNkrKR6FNeISaB3DsYW6oBjkptaN8ctWDmXHeHRXK89Uxv4qGsfEcR8bvxS5kWkF6TkPX9YwvRtORHZOBrNvykrgj7Td+Bdv+peVCX4NV50NOKCH9r90s2Uwf5ZwSWXrAfaix5Xqpyf"
}

output "fetched_info_from_aws_euc1" {
  value = format("%s%s", "ssh -i demo ubuntu@", aws_instance.ec2_example_east1.public_ip)
}
output "fetched_info_from_aws_east1" {
  value = format("%s%s", "ssh -i demo ubuntu@", aws_instance.ec2_example_east1.public_ip)
}
