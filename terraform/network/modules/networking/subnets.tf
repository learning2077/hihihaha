resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = local.azs[count.index % length(var.public_subnets)]

  tags = length(var.tags) == 0 ? {
    Name = var.public_subnets_name == "" ? "public-subnet-${local.azs[count.index % length(var.public_subnets)]}" : "${var.public_subnets_name}-${local.azs[count.index % length(var.public_subnets)]}"
  } : merge(var.tags, {
    Name = var.public_subnets_name == "" ? "public-subnet-${local.azs[count.index % length(var.public_subnets)]}" : "${var.public_subnets_name}-${local.azs[count.index % length(var.public_subnets)]}"
    })
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  
  vpc_id = aws_vpc.this.id
  cidr_block = var.private_subnets[count.index]
  availability_zone = local.azs[count.index % length(var.private_subnets)]

  tags = length(var.tags) == 0 ? {
    Name = var.private_subnets_name == "" ? "private-subnet-${local.azs[count.index % length(var.private_subnets)]}" : "${var.private_subnets_name}-${local.azs[count.index % length(var.private_subnets)]}"
  } : merge(var.tags, {
    Name = var.private_subnets_name == "" ? "private-subnet-${local.azs[count.index % length(var.private_subnets)]}" : "${var.private_subnets_name}-${local.azs[count.index % length(var.private_subnets)]}"
    })

  depends_on = [ aws_instance.nat ]
}

resource "aws_subnet" "database" {
  count = length(var.database_subnets)
  
  vpc_id = aws_vpc.this.id
  cidr_block = var.database_subnets[count.index]
  availability_zone = local.azs[count.index % length(var.database_subnets)]

  tags = length(var.tags) == 0 ? {
    Name = var.database_subnets_name == "" ? "database-subnet-${local.azs[count.index % length(var.database_subnets)]}" : "${var.database_subnets_name}-${local.azs[count.index % length(var.database_subnets)]}"
  } : merge(var.tags, {
    Name = var.database_subnets_name == "" ? "database-subnet-${local.azs[count.index % length(var.database_subnets)]}" : "${var.database_subnets_name}-${local.azs[count.index % length(var.database_subnets)]}"
    })
}