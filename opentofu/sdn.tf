resource "proxmox_virtual_environment_sdn_zone_vlan" "zone1" {
  id = "zone1"
  # nodes = ["pve"]  # Optional: omit to apply to all nodes in cluster
  bridge = "vmbr0"
  mtu    = 1500
}

resource "proxmox_virtual_environment_sdn_vnet" "vlan10" {
  id    = "vlan10"
  zone  = proxmox_virtual_environment_sdn_zone_vlan.zone1.id
  tag   = 10
  alias = "GESTION"
}

resource "proxmox_virtual_environment_sdn_vnet" "vlan20" {
  id    = "vlan20"
  zone  = proxmox_virtual_environment_sdn_zone_vlan.zone1.id
  tag   = 20
  alias = "DATA"
}

resource "proxmox_virtual_environment_sdn_vnet" "vlan30" {
  id    = "vlan30"
  zone  = proxmox_virtual_environment_sdn_zone_vlan.zone1.id
  tag   = 30
  alias = "SERVICE"
}

resource "proxmox_virtual_environment_sdn_vnet" "vlan40" {
  id    = "vlan40"
  zone  = proxmox_virtual_environment_sdn_zone_vlan.zone1.id
  tag   = 40
  alias = "DMZ"
}

resource "proxmox_virtual_environment_sdn_vnet" "vlan50" {
  id    = "vlan50"
  zone  = proxmox_virtual_environment_sdn_zone_vlan.zone1.id
  tag   = 50
  alias = "USER"
}

resource "proxmox_virtual_environment_sdn_vnet" "vlan60" {
  id    = "vlan60"
  zone  = proxmox_virtual_environment_sdn_zone_vlan.zone1.id
  tag   = 60
  alias = "IOT"
}

resource "proxmox_virtual_environment_sdn_vnet" "vlan70" {
  id    = "vlan70"
  zone  = proxmox_virtual_environment_sdn_zone_vlan.zone1.id
  tag   = 70
  alias = "GUEST"
}


resource "proxmox_virtual_environment_sdn_applier" "sdn_applier" {
  depends_on = [
    proxmox_virtual_environment_sdn_zone_vlan.zone1,
    proxmox_virtual_environment_sdn_vnet.vlan10,
    proxmox_virtual_environment_sdn_vnet.vlan20,
    proxmox_virtual_environment_sdn_vnet.vlan30,
    proxmox_virtual_environment_sdn_vnet.vlan40,
    proxmox_virtual_environment_sdn_vnet.vlan50,
    proxmox_virtual_environment_sdn_vnet.vlan60,
    proxmox_virtual_environment_sdn_vnet.vlan70
  ]
}

resource "proxmox_virtual_environment_sdn_applier" "finalizer" {
}