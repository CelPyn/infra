# Network

My home network consists of a double NAT setup. Proximus/Mobile Vikings Fiber comes in
and is terminated by a proprietary piece of Proximus hardware. It is then converted from
optic to copper via an ONT. A connection from the ONT box is made to the WAN Port on the Mobile Vikings
Internet Box. Port 1 on the Internet Box is connected to the WAN port on my Ubiquity router.

Subnetting:

Internet Box (Basically my guest network):

| Subnet Name      | CIDR             | Mask          | Gateway       |
|------------------|------------------|---------------|---------------|
| Primary Subnet   | 192.168.128.0/23 | 255.255.254.0 | 192.168.128.1 |
| Secondary Subnet | 192.168.1.0/24   | 255.255.255.0 | 192.168.1.1   |

Ubiquity Router:

| Subnet Name | CIDR         | Mask        | Gateway   | VLAN |
|-------------|--------------|-------------|-----------|------|
| Default     | 10.1.0.0/16  | 255.255.0.0 | 10.1.0.1  | 1    |
| Wifi        | 10.24.0.0/16 | 255.255.0.0 | 10.24.0.1 | 24   |
| Homelab     | 10.25.0.0/16 | 255.255.0.0 | 10.25.0.1 | 25   |
| VPN         | 10.26.0.0/16 | 255.255.0.0 | 10.25.0.1 | 26   |

Homelab subnet topology:

| Host type                 | IP Range                    | DHCP  |
|---------------------------|-----------------------------|-------|
| Physical Hosts            | 10.25.1.1 - 10.25.1.254     | false |
| Kubernetes Control Planes | 10.25.2.1 - 10.25.2.254     | false |
| Kubernetes Worker Nodes   | 10.25.3.1 - 10.25.3.254     | false |
| MetalLB LoadBalancers     | 10.25.4.1 - 10.25.4.254     | false |
| Other                     | 10.25.250.1 - 10.25.255.254 | true  |

VPN Subnet Topology:

| Host type                 | IP Range                    | DHCP  |
|---------------------------|-----------------------------|-------|
| VPN Devices               | 10.25.1.1 - 10.25.250.0     | false |
| Other                     | 10.25.250.1 - 10.25.255.254 | true  |
