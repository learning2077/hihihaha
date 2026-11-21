data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*"]
  }
}

data "aws_availability_zones" "all" {
  state = "available"
}

locals {
  azs = length(var.azs) == 0 ? data.aws_availability_zones.all.names : var.azs
}