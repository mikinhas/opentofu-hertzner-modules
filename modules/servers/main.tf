resource "hcloud_server" "this" {
  name        = var.name
  server_type = var.server_type
  image       = var.image
  location    = var.location
  ssh_keys    = var.ssh_keys
  user_data   = var.user_data
  labels      = var.labels
  backups     = var.backups
  firewall_ids      = var.firewall_ids
  placement_group_id = var.placement_group_id

  public_net {
    ipv4_enabled = var.public_net.ipv4_enabled
    ipv6_enabled = var.public_net.ipv6_enabled
  }

  dynamic "network" {
    for_each = var.network != null ? [var.network] : []
    content {
      network_id = network.value.network_id
      ip         = network.value.ip
      alias_ips  = network.value.alias_ips
    }
  }
}

resource "hcloud_volume" "this" {
  for_each = var.volumes

  name     = "${var.name}-${each.key}"
  size     = each.value.size
  format   = each.value.format
  location = coalesce(each.value.location, var.location)
}

resource "hcloud_volume_attachment" "this" {
  for_each = var.volumes

  volume_id = hcloud_volume.this[each.key].id
  server_id = hcloud_server.this.id
  automount = true
}
