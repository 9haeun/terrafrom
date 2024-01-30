output "scg" {
  value = { for k, v in aws_security_group.scg : v.tags.Name => v.id }
}