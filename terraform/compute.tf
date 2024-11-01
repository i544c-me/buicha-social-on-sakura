locals {
  server_num = 2
  agent_num  = 1
}

resource "sakuracloud_server" "k8s_server" {
  count = local.server_num

  name   = "k8s-server-${count.index}"
  core   = 4
  memory = 8
  disks  = [sakuracloud_disk.k8s_server[count.index].id]

  disk_edit_parameter {
    hostname   = "k8s-server-${count.index}"
    ssh_keys   = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2Rn7JefBOiZlbRfEdgEHYneUT8Bl1LH7I08cC2lxWP"]
    ip_address = sakuracloud_internet.main.ip_addresses[count.index]
    netmask    = sakuracloud_internet.main.netmask
    gateway    = sakuracloud_internet.main.gateway
  }

  network_interface {
    upstream         = sakuracloud_internet.main.switch_id
    packet_filter_id = sakuracloud_packet_filter.server.id
  }

  tags = ["buichasocial"]
}

data "sakuracloud_archive" "ubuntu" {
  os_type = "ubuntu2204"
}

resource "sakuracloud_disk" "k8s_server" {
  count = 2

  name              = "k3s-server-${count.index}"
  source_archive_id = data.sakuracloud_archive.ubuntu.id
  size              = 40
}

output "k8s_server_ip" {
  value = sakuracloud_server.k8s_server[*].ip_address
}


# agent

resource "sakuracloud_server" "k8s_agent" {
  count = local.agent_num

  name   = "k8s-agent-${count.index}"
  core   = 2
  memory = 4
  disks  = [sakuracloud_disk.k8s_agent[count.index].id]

  disk_edit_parameter {
    hostname   = "k3s-agent-${count.index}"
    ssh_keys   = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2Rn7JefBOiZlbRfEdgEHYneUT8Bl1LH7I08cC2lxWP"]
    ip_address = sakuracloud_internet.main.ip_addresses[local.server_num + count.index]
    netmask    = sakuracloud_internet.main.netmask
    gateway    = sakuracloud_internet.main.gateway
  }

  network_interface {
    upstream         = sakuracloud_internet.main.switch_id
    packet_filter_id = sakuracloud_packet_filter.server.id
  }

  tags = ["buichasocial"]
}

resource "sakuracloud_disk" "k8s_agent" {
  count = local.agent_num

  name              = "k3s-agent-${count.index}"
  source_archive_id = data.sakuracloud_archive.ubuntu.id
  size              = 40
}

output "k8s_agent_ip" {
  value = sakuracloud_server.k8s_agent[*].ip_address
}


# Packet filter
# パケットフィルタ | さくらのクラウド マニュアル https://manual.sakura.ad.jp/cloud/network/packet-filter.html
resource "sakuracloud_packet_filter" "server" {
  name = "server"

  expression {
    protocol         = "tcp"
    destination_port = "22"
  }

  expression {
    protocol         = "tcp"
    destination_port = "80"
  }

  expression {
    protocol         = "tcp"
    destination_port = "443"
  }

  expression {
    protocol       = "ip"
    source_network = "${sakuracloud_internet.main.network_address}/${sakuracloud_internet.main.netmask}"
    description    = "Allow private network"
  }

  # NTP からのレスポンスを許可
  expression {
    protocol       = "udp"
    source_network = "210.188.224.14"
    source_port    = "123"
    description    = "Allow NTP"
  }

  # 戻りパケットを許可
  expression {
    protocol         = "tcp"
    destination_port = "1024-65535"
    description      = "Allow 戻りパケット"
  }

  expression {
    protocol         = "udp"
    destination_port = "1024-65535"
    description      = "Allow 戻りパケット"
  }

  # ICMP パケットを許可
  expression {
    protocol = "icmp"
  }

  # fragment パケットを許可
  expression {
    protocol = "fragment"
  }

  expression {
    protocol    = "ip"
    allow       = false
    description = "Deny ALL"
  }
}
