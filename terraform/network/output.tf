output "public" {
  value = module.network.public_subnets
}

output "private" {
  value = module.network.private_subnets
}

output "database" {
  value = module.network.database_subnets
}

output "vpc_id" {
  value = module.network.vpc_id
}