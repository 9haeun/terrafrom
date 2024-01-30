resource "aws_security_group" "scg" {
  for_each    = { for scg in var.scg : scg.name => scg }
  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = each.key
  }
}
resource "aws_security_group_rule" "scg_rule" {
  for_each                 = { for rule in var.scg_rule : join("-", [rule.scg_name, rule.src, rule.protocol, rule.from_port, rule.to_port]) => rule }
  type                     = "ingress"
  security_group_id        = aws_security_group.scg[each.value.scg_name].id
  description              = each.value.description
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = length(regexall("[a-z]", each.value.src)) == 0 ? [each.value.src] : null                  #Cidr
  prefix_list_ids          = split("-", each.value.src)[0] == "pl" ? [each.value.src] : null                           #Vpc Ept
  source_security_group_id = split("-", each.value.src)[0] == "scg" ? aws_security_group.scg[each.value.src].id : null # Other Scg
  #   ipv6_cidr_blocks  =
}