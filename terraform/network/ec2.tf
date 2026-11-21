data "aws_ami" "al2023_x86_64" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*"]
  }
}

resource "aws_instance" "test" {
  count = 2

  ami = data.aws_ami.al2023_x86_64.id

  instance_type = "t2.small"

  subnet_id = module.network.public_subnets[count.index % length(module.network.public_subnets)]

  iam_instance_profile = module.network.role

  associate_public_ip_address = true
}