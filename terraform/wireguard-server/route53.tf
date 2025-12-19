data "aws_route53_zone" "this" {
  name = "pynenborg.com"
}

resource "aws_route53_record" "wireguard" {
  name    = "vpn.pynenborg.com"
  type    = "A"
  zone_id = data.aws_route53_zone.this.zone_id
  ttl     = "300"
  records = [hcloud_primary_ip.this.ip_address]
}
