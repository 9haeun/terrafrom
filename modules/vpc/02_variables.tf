# VPC Module
variable "vpc" {
  type = list(object({
    name = string
    cidr = string
    igw  = optional(string)
    dns_hostnames = optional(bool)
  }))
}

variable "subnet" {
  type = list(object({
    availability_zone = string
    cidr_block        = string
    name              = string
    rtb               = string
    vpc               = string
  }))
}

variable "rtb" {
  type = list(object({
    name = string
    vpc  = string
  }))
}

variable "eip" {
  type = list(object({
    name = string
  }))
}

variable "ngw" {
  type = list(object({
    name = string
    subnet  = string
    eip = string
  }))
}


