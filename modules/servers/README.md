# opentofu-hetzner-server-module

OpenTofu/Terraform module to create a [Hetzner Cloud](https://www.hetzner.com/cloud) server with optional volumes and private network.

## Features

- Create a Hetzner Cloud server with configurable type, image, and location
- Attach additional volumes with automatic formatting and mounting
- Configure public and private networking
- Assign firewalls, placement groups, SSH keys, and labels
- Cloud-init support via `user_data`

## Usage

```hcl
module "server" {
  source = "git::https://github.com/mikinhas/opentofu-hertzner-modules.git//modules/servers?ref=servers/v0.1.0"

  name        = "my-server"
  server_type = "cx22"
  image       = "ubuntu-24.04"
  location    = "fsn1"
  ssh_keys    = ["my-key"]

  volumes = {
    data = {
      size   = 50
      format = "ext4"
    }
  }
}
```

### With private network

```hcl
resource "hcloud_network" "main" {
  name     = "my-network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "main" {
  network_id   = hcloud_network.main.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

module "server" {
  source = "git::https://github.com/mikinhas/opentofu-hertzner-modules.git//modules/servers?ref=servers/v0.1.0"

  name        = "my-server"
  server_type = "cx22"
  ssh_keys    = ["my-key"]

  network = {
    network_id = hcloud_network.main.id
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name of the server | `string` | — | yes |
| `server_type` | Hetzner server type (e.g. cx22, cx32, cx42) | `string` | `"cx22"` | no |
| `image` | OS image (e.g. ubuntu-24.04, debian-12) | `string` | `"ubuntu-24.04"` | no |
| `location` | Datacenter location (e.g. fsn1, nbg1, hel1, ash, hil) | `string` | `"fsn1"` | no |
| `ssh_keys` | List of SSH key IDs or names | `list(string)` | `[]` | no |
| `user_data` | Cloud-init user data | `string` | `null` | no |
| `labels` | Labels to attach to the server | `map(string)` | `{}` | no |
| `backups` | Enable automatic backups | `bool` | `false` | no |
| `public_net` | Public network config (`ipv4_enabled`, `ipv6_enabled`) | `object` | `{ ipv4_enabled = true, ipv6_enabled = true }` | no |
| `network` | Private network config (`network_id`, `ip`, `alias_ips`) | `object` | `null` | no |
| `firewall_ids` | List of firewall IDs to attach | `list(number)` | `[]` | no |
| `placement_group_id` | Placement group ID | `number` | `null` | no |
| `volumes` | Map of volumes to create and attach (`size`, `format`, `location`) | `map(object)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | ID of the server |
| `name` | Name of the server |
| `ipv4_address` | Public IPv4 address |
| `ipv6_address` | Public IPv6 address |
| `status` | Status of the server |
| `volumes` | Map of created volumes with their IDs and linux devices |

## Requirements

| Name | Version |
|------|---------|
| OpenTofu/Terraform | >= 1.6.0 |
| hcloud provider | >= 1.45.0 |

## License

MIT — see [LICENSE](../../LICENSE) for details.
