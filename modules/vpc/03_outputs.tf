output "vpc" {
  value = {for k, v in aws_vpc.vpc : v.tags.Name => v.id }
}

output "igw" {
  value = {for k, v in aws_internet_gateway.igw : v.tags.Name => v.id }
}

output "subnet" {
  value = {for k, v in aws_subnet.subnet : v.tags.Name => v.id }
}

output "rtb" {
  value = {for k, v in aws_route_table.rtb : v.tags.Name => v.id }
}

output "ngw" {
  value = {for k, v in aws_nat_gateway.ngw : v.tags.Name => v.id }
}
