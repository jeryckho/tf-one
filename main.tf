// docker run -it --rm -v /c/Users/jerome.chery/terraform:/data broadinstitute/terraform plan

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

resource "aws_instance" "montest" {
  ami           = "ami-7d50491b"
  instance_type = "t2.micro"
}
