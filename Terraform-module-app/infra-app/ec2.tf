




resource "aws_key_pair" "my_key" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("terra-key-ec2.pub")

  tags = {
    Environment = var.env
  }

}

resource "aws_default_vpc" "my_vpc" {
  tags = {
    Name = "my_vpc"
  }
}

resource "aws_security_group" "my_security_group" { 
  name   = "${var.env}-infra-app-sg"
  vpc_id = aws_default_vpc.my_vpc.id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh open"
  }


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http open"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "outbound open"
  }



}


resource "aws_instance" "my_instance" {
  count = var.instance_count
  key_name        = aws_key_pair.my_key.key_name
  #count           = 2 # meta argument  and i use first time count 
  
  depends_on = [ aws_security_group.my_security_group, aws_key_pair.my_key ] # meta argument if security group is correct then create instance

  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = var.instance_type
  ami             = var.ec2_ami_id
  
  root_block_device {
    volume_size = var.env == "prd" ? 20 : 10 
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.env}-infra-app-instance"
    Environment = var.env
  }


}