resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = length(var.tags) == 0 ? {
    Name = var.vpc_name == "" ? "main-vpc" : var.vpc_name
  } : merge(var.tags, {
    Name = var.vpc_name == "" ? "main-vpc" : var.vpc_name
  })
}