variable "azs" {
  type = list(string)
  default = []
}

variable "cidr_block" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    "environment" = "dev"
    "test" = "network"
  }
}

variable "public_subnets" {
  type = list(string)
  default = []
}

variable "private_subnets" {
  type = list(string)
  default = []
}

variable "database_subnets" {
  type = list(string)
  default = []
}

variable "vpc_name" {
  type = string
  default = ""
}

variable "public_subnets_name" {
  type = string
  default = ""
}

variable "private_subnets_name" {
  type = string
  default = ""
}

variable "database_subnets_name" {
  type = string
  default = ""
}