# opentofu-hertzner-modules

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![OpenTofu](https://img.shields.io/badge/OpenTofu-%E2%89%A5%201.6-7B42BC)](https://opentofu.org/)
[![Release Please](https://img.shields.io/badge/release-please-1E90FF)](https://github.com/googleapis/release-please)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-FE5196)](https://www.conventionalcommits.org/)

A collection of [OpenTofu](https://opentofu.org/) modules for provisioning
[Hetzner Cloud](https://www.hetzner.com/cloud) resources.

Each module lives under [`modules/`](./modules) and is released independently
with its own version tag.

## Modules

| Module | Description |
|--------|-------------|
| [`networks`](./modules/networks) | Hetzner Cloud network with its subnets and routes managed together. |
| [`servers`](./modules/servers) | Hetzner Cloud server with optional volumes, private network, firewalls, and cloud-init. |

## Usage

Consume a module with the Git source, pinning to a module-scoped tag:

```hcl
module "network" {
  source = "git::https://github.com/mikinhas/opentofu-hertzner-modules.git//modules/networks?ref=networks/v0.1.0"

  # ... module inputs
}
```

Each module's `README.md` documents its inputs, outputs, and usage.

## Requirements

- OpenTofu `>= 1.6`
- hcloud provider `>= 1.45`
- A Hetzner Cloud API token exposed as `HCLOUD_TOKEN`

Individual modules may impose additional requirements — see their README.

## Versioning & releases

Modules are versioned **independently** following [Semantic Versioning](https://semver.org/).
Tags are prefixed with the module name: `networks/v1.2.0`, `servers/v0.3.1`, etc.

Releases are managed by [release-please](https://github.com/googleapis/release-please):
commits following the [Conventional Commits](https://www.conventionalcommits.org/)
specification drive automated version bumps and changelog generation.

Scope your commits with the module name so only that module is bumped:

```
feat(networks): add support for vSwitch subnets
fix(servers): correct default for public_net.ipv6_enabled
feat(servers)!: rename variable network → private_network
```

## Contributing

Contributions are welcome. See [`CONTRIBUTING.md`](./CONTRIBUTING.md) for the
commit convention, PR workflow, and release process.

## License

[MIT](./LICENSE)
