variable "cluster_name" {
  description = "A name to provide for the Talos cluster"
  type        = string
  default     = "homelab"
}

variable "cluster_endpoint" {
  description = "The endpoint for the Talos cluster"
  type        = string
  default     = "https://10.25.2.1:6443"
}

variable "node_data" {
  description = "A map of node data"
  type = object({
    controlplanes = map(object({
      install_disk = string
      hostname = string
    }))
    workers = map(object({
      install_disk = string
      hostname = string
    }))
  })
  default = {
    controlplanes = {
      "10.25.2.1" = {
        install_disk = "/dev/sda"
        hostname     = "control-plane-0"
      }
    }
    workers = {
      "10.25.3.1" = {
        install_disk = "/dev/sda"
        hostname     = "node-0"
      }
    }
  }
}
