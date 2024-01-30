# Vpc
resource "aws_vpc" "vpc" {
  for_each             = { for vpc in var.vpc : vpc.name => vpc }
  cidr_block           = each.value.cidr
  enable_dns_hostnames = each.value.dns_hostnames
  tags = {
    Name = each.key
  }
}
resource "aws_internet_gateway" "igw" {
  for_each = { for vpc in var.vpc : vpc.igw => vpc if vpc.igw != null }
  vpc_id   = aws_vpc.vpc[each.value.name].id
  tags = {
    Name = each.key
  }
}

# Subnet
resource "aws_subnet" "subnet" {
  for_each          = { for subnet in var.subnet : subnet.name => subnet } # 변환
  vpc_id            = aws_vpc.vpc[each.value.vpc].id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.key
  }
}

# rtb
resource "aws_route_table" "rtb" {
  for_each = { for rtb in var.rtb : rtb.name => rtb }
  vpc_id   = aws_vpc.vpc[each.value.vpc].id
  tags = {
    Name = each.key
  }
}

# rtb associate
resource "aws_route_table_association" "rt_association" {
  for_each       = { for subnet in var.subnet : join("-", [subnet.name, subnet.rtb]) => subnet }
  subnet_id      = aws_subnet.subnet[each.value.name].id
  route_table_id = aws_route_table.rtb[each.value.rtb].id
}

# eip
resource "aws_eip" "eip" {
  for_each = { for eip in var.eip : eip.name => eip}
  domain = "vpc"
  tags = {
    Name = each.key
  }
}

# nat_gw
resource "aws_nat_gateway" "ngw" {
  for_each       = { for ngw in var.ngw : ngw.name => ngw }
  subnet_id      = aws_subnet.subnet[each.value.subnet].id
  allocation_id = aws_eip.eip[each.value.eip].id
  tags = {
    Name = each.key
  }
  depends_on = [aws_internet_gateway.igw]
}
