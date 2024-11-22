resource "aws_route53_record" "bluesky" {
  name    = "_atproto"
  type    = "TXT"
  zone_id = data.aws_route53_zone.this.zone_id
  ttl     = "300"
  records = ["did=did:plc:4pkxz3rsw5fagee2ronbjiiq"]
}

data "aws_route53_zone" "this" {
  name = "pynenborg.com"
}
