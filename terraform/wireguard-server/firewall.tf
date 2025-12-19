data "http" "public_ip" {
  url = "https://ipv4.icanhazip.com"
}

resource "hcloud_firewall" "firewall" {
  name = "wireguard-firewall"
  rule {
    direction = "in"
    protocol  = "udp"
    port      = "51820"
    source_ips = [
      "0.0.0.0/0",
      "::/0",
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "${chomp(data.http.public_ip.response_body)}/32",
    ]
  }
}
