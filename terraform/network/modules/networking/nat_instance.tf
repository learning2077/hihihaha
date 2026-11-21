resource "aws_security_group" "nat_sg" {
  name        = "nat-instance-sg"
  description = "Allow private subnet traffic to route outbound"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.private_subnets
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = length(var.tags) == 0 ? {
    Name = "nat-instance-sg"
  } : merge(var.tags, {
    Name = "nat-instance-sg"
  })
}

resource "aws_instance" "nat" {
  ami = data.aws_ami.al2023.id
  instance_type = "t4g.nano"
  subnet_id = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.nat_sg.id]
  associate_public_ip_address = true

  source_dest_check = false

  user_data = file("${path.module}/configs/user_data.sh")

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = length(var.tags) == 0 ? {
    Name = "nat-instance"
  } : merge(var.tags, {
    Name = "nat-instance"
  })
}