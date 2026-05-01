resource "hcloud_network" "this" {
  name              = var.name
  ip_range          = var.ip_range
  labels            = var.labels
  delete_protection = var.delete_protection
}

resource "hcloud_network_subnet" "this" {
  for_each = var.subnets

  network_id   = hcloud_network.this.id
  type         = each.value.type
  network_zone = each.value.network_zone
  ip_range     = each.value.ip_range
  vswitch_id   = each.value.vswitch_id
}

resource "hcloud_network_route" "this" {
  for_each = var.routes

  network_id  = hcloud_network.this.id
  destination = each.value.destination
  gateway     = each.value.gateway
}
