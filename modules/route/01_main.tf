resource "aws_route" "route" {
  for_each               = { for route in var.rtb_rule : join("-to-", [route.rtb_id, route.dst_cidr]) => route }
  route_table_id         = each.value.rtb_id
  destination_cidr_block = each.value.dst_cidr
  # destination_ipv6_cidr_block = 
  # destination_prefix_list_id = 
  gateway_id                = contains(["igw", "vgw"], split("-", each.value.dst_id)[0]) ? each.value.dst_id : null
  carrier_gateway_id        = split("-", each.value.dst_id)[0] == "cagw" ? each.value.dst_id : null
  core_network_arn          = split("-", each.value.dst_id)[0] == "arn" ? each.value.dst_id : null
  egress_only_gateway_id    = split("-", each.value.dst_id)[0] == "eigw" ? each.value.dst_id : null
  nat_gateway_id            = split("-", each.value.dst_id)[0] == "nat" ? each.value.dst_id : null
  local_gateway_id          = split("-", each.value.dst_id)[0] == "lgw" ? each.value.dst_id : null
  network_interface_id      = split("-", each.value.dst_id)[0] == "eni" ? each.value.dst_id : null
  transit_gateway_id        = split("-", each.value.dst_id)[0] == "tgw" ? each.value.dst_id : null
  vpc_endpoint_id           = split("-", each.value.dst_id)[0] == "vpce" ? each.value.dst_id : null
  vpc_peering_connection_id = split("-", each.value.dst_id)[0] == "pcx" ? each.value.dst_id : null

}


