data "aws_ami" "nat_ami" {
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  name_regex = "^amzn-ami-hvm-.*-x86_64-gp2$"
  owners     = ["amazon"]
}
