// docker run -it --rm -v /c/Users/jerome.chery/terraform:/data broadinstitute/terraform plan
// docker run -it --rm -v /c/Users/Anguerand/terraform:/data broadinstitute/terraform plan

variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-west-1"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_security_group" "websg" {
  name        = "web_security_group"
  description = "Security Group for Web"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 1880
    to_port     = 1880
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "WebSG"
  }
}

resource "aws_instance" "myweb" {
  ami           = "ami-7d50491b"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.websg.id}"]

  ebs_block_device{
    device_name = "/dev/sdf"
    volume_size = 16
    volume_type = "gp2"
  }
  
  tags {
    Name = "Web"
  }
}
