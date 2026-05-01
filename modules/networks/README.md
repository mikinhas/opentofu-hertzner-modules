# OpenTofu Hetzner Network Module

OpenTofu module for creating and managing networks, subnets, and routes on Hetzner Cloud.

## Usage

```hcl
module "network" {
  source = "git::https://github.com/mikinhas/opentofu-hertzner-modules.git//modules/networks?ref=networks/v0.1.0"

  name     = "my-network"
  ip_range = "10.0.0.0/16"

  labels = {
    environment = "production"
    managed_by  = "opentofu"
  }

  subnets = {
    web = {
      type         = "cloud"
      network_zone = "eu-central"
      ip_range     = "10.0.1.0/24"
    }
    app = {
      type         = "cloud"
      network_zone = "eu-central"
      ip_range     = "10.0.2.0/24"
    }
  }

  routes = {
    vpn = {
      destination = "192.168.0.0/24"
      gateway     = "10.0.1.1"
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| opentofu | >= 1.6.0 |
| hcloud | >= 1.45.0 |

## Resources

| Name | Type |
|------|------|
| [hcloud_network.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network) | resource |
| [hcloud_network_subnet.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_route.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name of the network | `string` | — | yes |
| `ip_range` | IP range of the network (CIDR notation) | `string` | — | yes |
| `labels` | Labels to attach to the network | `map(string)` | `{}` | no |
| `delete_protection` | Enable delete protection for the network | `bool` | `false` | no |
| `subnets` | Map of subnets to create within the network | `map(object)` | `{}` | no |
| `routes` | Map of routes to create within the network | `map(object)` | `{}` | no |

### Subnet object

| Key | Description | Type | Required |
|-----|-------------|------|----------|
| `type` | Type of subnet (`cloud`, `vswitch`, `server`) | `string` | yes |
| `network_zone` | Network zone (`eu-central`, `us-east`, `us-west`, `ap-southeast`) | `string` | yes |
| `ip_range` | IP range of the subnet (CIDR notation) | `string` | yes |
| `vswitch_id` | ID of the vSwitch (only for `vswitch` type) | `number` | no |

### Route object

| Key | Description | Type | Required |
|-----|-------------|------|----------|
| `destination` | Destination network (CIDR notation) | `string` | yes |
| `gateway` | Gateway IP address | `string` | yes |

## Outputs

| Name | Description |
|------|-------------|
| `network_id` | ID of the network |
| `network_name` | Name of the network |
| `network_ip_range` | IP range of the network |
| `subnet_ids` | Map of subnet keys to their IDs |
| `route_ids` | Map of route keys to their IDs |

## License

[MIT](../../LICENSE)
