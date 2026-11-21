resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = length(var.tags) == 0 ? null : var.tags
}

# ==============================================
#                    public
# ==============================================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = length(var.tags) == 0 ? null : var.tags
}

resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# ==============================================
#                    private
# ==============================================

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = length(var.tags) == 0 ? null : var.tags
}

resource "aws_route" "private" {
  route_table_id = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id = aws_instance.nat.primary_network_interface_id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}