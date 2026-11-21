output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "database_subnets" {
  value = aws_subnet.database[*].id
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "role" {
  value = aws_iam_instance_profile.ec2_profile.name
}