resource "sakuracloud_server" "k3s_server" {
  name   = "k3s-server"
  core   = 2
  memory = 4
  disks  = [sakuracloud_disk.k3s_server.id]

  disk_edit_parameter {
    hostname = "k3s-server"
    ssh_keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2Rn7JefBOiZlbRfEdgEHYneUT8Bl1LH7I08cC2lxWP"]
  }

  network_interface {
    upstream = "shared"
  }

  tags = ["buichasocial"]
}

data "sakuracloud_archive" "ubuntu" {
  os_type = "ubuntu2204"
}

resource "sakuracloud_disk" "k3s_server" {
  name              = "k3s-server"
  source_archive_id = data.sakuracloud_archive.ubuntu.id
}

# agent-1

resource "sakuracloud_server" "k3s_agent_1" {
  name   = "k3s-agent-1"
  core   = 1
  memory = 1
  disks  = [sakuracloud_disk.k3s_agent_1.id]

  disk_edit_parameter {
    hostname = "k3s-agent-1"
    ssh_keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2Rn7JefBOiZlbRfEdgEHYneUT8Bl1LH7I08cC2lxWP"]
  }

  network_interface {
    upstream = "shared"
  }

  tags = ["buichasocial"]
}

resource "sakuracloud_disk" "k3s_agent_1" {
  name              = "k3s-agent-1"
  source_archive_id = data.sakuracloud_archive.ubuntu.id
}
