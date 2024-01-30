variable "scg" {
  type = list(object({
    name        = string
    description = string
    vpc_id      = string
  }))
}
variable "scg_rule" {
  type = list(object({
    scg_name    = string
    description = optional(string)
    protocol    = string
    from_port   = string
    to_port     = string
    src         = string
    vpc_id      = string
  }))
}