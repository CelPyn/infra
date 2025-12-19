data "hcloud_ssh_key" "this" {
  name = "Hetzner"
}

resource "hcloud_primary_ip" "this" {
  name          = "primary_ip_test"
  datacenter    = "nbg1-dc3"
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = false
}

resource "hcloud_server" "wireguard-server" {
  name        = "wireguard"
  image       = "debian-13"
  server_type = "cax11"
  datacenter  = "nbg1-dc3"
  ssh_keys    = [data.hcloud_ssh_key.this.id]

  firewall_ids = [hcloud_firewall.firewall.id]

  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.this.id
    ipv6_enabled = true
  }

  lifecycle {
    ignore_changes = [ssh_keys]
  }
}
