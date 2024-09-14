output "k3s_server_ip" {
  value = sakuracloud_server.k3s_server.ip_address
}

output "k3s_agent_1_ip" {
  value = sakuracloud_server.k3s_agent_1.ip_address
}
