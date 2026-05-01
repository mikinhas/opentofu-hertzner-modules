output "network_id" {
  description = "ID of the network."
  value       = hcloud_network.this.id
}

output "network_name" {
  description = "Name of the network."
  value       = hcloud_network.this.name
}

output "network_ip_range" {
  description = "IP range of the network."
  value       = hcloud_network.this.ip_range
}

output "subnet_ids" {
  description = "Map of subnet keys to their IDs."
  value       = { for k, v in hcloud_network_subnet.this : k => v.id }
}

output "route_ids" {
  description = "Map of route keys to their IDs."
  value       = { for k, v in hcloud_network_route.this : k => v.id }
}
