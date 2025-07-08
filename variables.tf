variable "region" {
  description = "AWS region name that will be using"
  type        = string
}

variable "env" {
  description = "environment (prod - dev - stage)"
  type        = string
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "aws_subnet_private_ids" {
  description = "The Private Subnets"
  type = list(string)
}