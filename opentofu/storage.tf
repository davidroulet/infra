resource "proxmox_virtual_environment_storage_nfs" "iso-repo" {
  id     = "iso-repo"
  server = "192.168.10.202"
  export = "/mnt/pool-lab/isonfs"

  content = ["images", "iso", "backup"]

  options                  = "vers=4.2"
  preallocation            = "metadata"
  snapshot_as_volume_chain = true

  backups {
    max_protected_backups = 5
    keep_daily            = 7
  }
}
##https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_storage_nfs