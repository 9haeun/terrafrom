variable "rtb_rule" {
  type = list(object({
    rtb_id   = string
    dst_cidr = string
    dst_id   = string
  }))
}