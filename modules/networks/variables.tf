variable "name" {
  description = "Name of the network."
  type        = string
}

variable "ip_range" {
  description = "IP range of the network (CIDR notation, e.g. 10.0.0.0/16)."
  type        = string
}

variable "labels" {
  description = "Labels to attach to the network."
  type        = map(string)
  default     = {}
}

variable "delete_protection" {
  description = "Enable delete protection for the network."
  type        = bool
  default     = false
}

variable "subnets" {
  description = "Map of subnets to create within the network."
  type = map(object({
    type         = string
    network_zone = string
    ip_range     = string
    vswitch_id   = optional(number)
  }))
  default = {}
}

variable "routes" {
  description = "Map of routes to create within the network."
  type = map(object({
    destination = string
    gateway     = string
  }))
  default = {}
}
