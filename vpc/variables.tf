variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "worker_count" {
  default = "2"
}

variable "worker_subnet_cidr" {
  type = "list"

  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "worker_subnet_zones" {
  type = "list"

  default = ["us-east-1a", "us-east-1b"]
}

variable "manager_count" {
  default = "1"
}

variable "manager_subnet_cidr" {
  type = "list"

  default = ["10.0.3.0/24"]
}

variable "manager_subnet_zones" {
  type = "list"

  default = ["us-east-1c"]
}

variable "controller_count" {
  default = "1"
}

variable "controller_subnet_cidr" {
  type = "list"

  default = ["10.0.4.0/24"]
}

variable "controller_subnet_zones" {
  type = "list"

  default = ["us-east-1d"]
}

variable "public_subnet_cidr" {
  default = "10.0.5.0/24"
}

variable "public_subnet_zone" {
  default = "us-east-1e"
}

variable "nat_amis" {
  type = "map"

  default = {
    us-east-1 = "ami-184dc970"
  }
}
