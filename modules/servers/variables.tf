variable "name" {
  description = "Name of the server"
  type        = string
}

variable "server_type" {
  description = "Hetzner server type (e.g. cx22, cx32, cx42)"
  type        = string
  default     = "cx22"
}

variable "image" {
  description = "OS image to use (e.g. ubuntu-24.04, debian-12)"
  type        = string
  default     = "ubuntu-24.04"
}

variable "location" {
  description = "Hetzner datacenter location (e.g. fsn1, nbg1, hel1, ash, hil)"
  type        = string
  default     = "fsn1"
}

variable "ssh_keys" {
  description = "List of SSH key IDs or names to add to the server"
  type        = list(string)
  default     = []
}

variable "user_data" {
  description = "Cloud-init user data"
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels to attach to the server"
  type        = map(string)
  default     = {}
}

variable "backups" {
  description = "Enable automatic backups"
  type        = bool
  default     = false
}

variable "public_net" {
  description = "Public network configuration"
  type = object({
    ipv4_enabled = optional(bool, true)
    ipv6_enabled = optional(bool, true)
  })
  default = {}
}

variable "network" {
  description = "Private network configuration"
  type = object({
    network_id = number
    ip         = optional(string)
    alias_ips  = optional(list(string), [])
  })
  default = null
}

variable "firewall_ids" {
  description = "List of firewall IDs to attach to the server"
  type        = list(number)
  default     = []
}

variable "placement_group_id" {
  description = "Placement group ID for the server"
  type        = number
  default     = null
}

variable "volumes" {
  description = "Map of volumes to create and attach"
  type = map(object({
    size     = number
    format   = optional(string, "ext4")
    location = optional(string)
  }))
  default = {}
}
