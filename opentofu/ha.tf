resource "proxmox_virtual_environment_haresource" "dns_ha" {
  # On lie la HA à la ressource VM spécifique
  depends_on  = [proxmox_virtual_environment_vm.dns]
  resource_id = "vm:${proxmox_virtual_environment_vm.dns.vm_id}"
  state       = "started"
}

resource "proxmox_virtual_environment_harule" "prefer-node-mazda" {
  rule      = "prefer-node-mazda"
  type      = "node-affinity"
  comment   = "Prefer node1 for these VMs"
  resources = ["vm:${proxmox_virtual_environment_vm.dns.vm_id}"]

  nodes = {
    pve-mazda = 2 # Higher priority
    pve-opel  = 1
    pve-audi  = 1
  }

  strict = false
  depends_on = [
    proxmox_virtual_environment_haresource.dns_ha

  ]
}