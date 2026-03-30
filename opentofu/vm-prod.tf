resource "proxmox_virtual_environment_vm" "dns" {
  name            = "dns.sureau.ch"
  description     = "Managed by Terraform"
  tags            = ["terraform", "debian", "staging"]
  node_name       = "pve-mazda"
  vm_id           = 3020
  keyboard_layout = "fr-ch"
  agent {
    enabled = true
  }
  cpu {
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }
  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }
  disk {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    import_from  = proxmox_virtual_environment_download_file.debian_13_trixie_qcow2_img.id
    interface    = "scsi0"
  }
  initialization {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    ip_config {
      ipv4 {
        address = "192.168.10.28/24"
        gateway = "192.168.10.1"
      }
    }
    user_data_file_id = "isonfs:snippets/cloud-config-ansible.yaml"
  }
  network_device {
    bridge = "vmbr0"
    model  = "virtio" # Recommandé pour Debian/Linux
  }
  depends_on = [
    proxmox_virtual_environment_sdn_zone_vlan.zone1,
    proxmox_virtual_environment_sdn_vnet.vlan30
  ]
}
################################################################################################33
resource "proxmox_virtual_environment_vm" "proxy" {
  name            = "proxy.sureau.ch"
  description     = "Managed by Terraform"
  tags            = ["terraform", "debian", "staging"]
  node_name       = "pve-audi"
  vm_id           = 2050
  keyboard_layout = "fr-ch"
  agent {
    enabled = true
  }
  cpu {
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }
  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }
  disk {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    import_from  = proxmox_virtual_environment_download_file.debian_13_trixie_qcow2_img.id
    interface    = "scsi0"
  }
  initialization {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    ip_config {
      ipv4 {
        address = "192.168.10.38/24"
        gateway = "192.168.10.1"
      }
    }
    user_data_file_id = "isonfs:snippets/cloud-config-ansible.yaml"
  }
  network_device {
    bridge = "vmbr0"
    model  = "virtio" # Recommandé pour Debian/Linux
  }
  depends_on = [
    proxmox_virtual_environment_sdn_zone_vlan.zone1,
    proxmox_virtual_environment_sdn_vnet.vlan10
  ]
}
################################################################################################33
resource "proxmox_virtual_environment_vm" "docker" {
  name            = "docker.sureau.ch"
  description     = "Managed by Terraform"
  tags            = ["terraform", "debian", "staging"]
  node_name       = "pve-audi"
  vm_id           = 3040
  keyboard_layout = "fr-ch"
  agent {
    enabled = true
  }
  cpu {
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }
  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }
  disk {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    import_from  = proxmox_virtual_environment_download_file.debian_13_trixie_qcow2_img.id
    interface    = "scsi0"
  }
  initialization {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    ip_config {
      ipv4 {
        address = "192.168.10.39/24"
        gateway = "192.168.10.1"
      }
    }
    user_data_file_id = "isonfs:snippets/cloud-config-ansible.yaml"
  }
  network_device {
    bridge = "vmbr0"
    model  = "virtio" # Recommandé pour Debian/Linux
  }
  depends_on = [
    proxmox_virtual_environment_sdn_zone_vlan.zone1,
    proxmox_virtual_environment_sdn_vnet.vlan30
  ]
}
################################################################################################33
resource "proxmox_virtual_environment_vm" "drive" {
  name            = "drive.sureau.ch"
  description     = "Managed by Terraform"
  tags            = ["terraform", "debian", "staging"]
  node_name       = "pve-opel"
  vm_id           = 3050
  keyboard_layout = "fr-ch"
  agent {
    enabled = true
  }
  cpu {
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }
  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }
  disk {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    import_from  = proxmox_virtual_environment_download_file.debian_13_trixie_qcow2_img.id
    interface    = "scsi0"
  }
  initialization {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    ip_config {
      ipv4 {
        address = "192.168.10.36/24"
        gateway = "192.168.10.1"
      }
    }
    user_data_file_id = "isonfs:snippets/cloud-config-ansible.yaml"
  }
  network_device {
    bridge = "vmbr0"
    model  = "virtio" # Recommandé pour Debian/Linux
  }
  depends_on = [
    proxmox_virtual_environment_sdn_zone_vlan.zone1,
    proxmox_virtual_environment_sdn_vnet.vlan30
  ]
}
################################################################################################33
resource "proxmox_virtual_environment_vm" "crm" {
  name            = "crm.sureau.ch"
  description     = "Managed by Terraform"
  tags            = ["terraform", "debian", "staging"]
  node_name       = "pve-opel"
  vm_id           = 3060
  keyboard_layout = "fr-ch"
  agent {
    enabled = true
  }
  cpu {
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }
  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }
  disk {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    import_from  = proxmox_virtual_environment_download_file.debian_13_trixie_qcow2_img.id
    interface    = "scsi0"
  }
  initialization {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    ip_config {
      ipv4 {
        address = "192.168.10.31/24"
        gateway = "192.168.10.1"
      }
    }
    user_data_file_id = "isonfs:snippets/cloud-config-ansible.yaml"
  }
  network_device {
    bridge = "vmbr0"
    model  = "virtio" # Recommandé pour Debian/Linux
  }
  depends_on = [
    proxmox_virtual_environment_sdn_zone_vlan.zone1,
    proxmox_virtual_environment_sdn_vnet.vlan30
  ]
}
################################################################################################33
resource "proxmox_virtual_environment_vm" "auth" {
  name            = "auth.sureau.ch"
  description     = "Managed by Terraform"
  tags            = ["terraform", "debian", "staging"]
  node_name       = "pve-mazda"
  vm_id           = 3070
  keyboard_layout = "fr-ch"
  agent {
    enabled = true
  }
  cpu {
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }
  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }
  disk {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    import_from  = proxmox_virtual_environment_download_file.debian_13_trixie_qcow2_img.id
    interface    = "scsi0"
  }
  initialization {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    ip_config {
      ipv4 {
        address = "192.168.10.33/24"
        gateway = "192.168.10.1"
      }
    }
    user_data_file_id = "isonfs:snippets/cloud-config-ansible.yaml"
  }
  network_device {
    bridge = "vmbr0"
    model  = "virtio" # Recommandé pour Debian/Linux
  }
  depends_on = [
    proxmox_virtual_environment_sdn_zone_vlan.zone1,
    proxmox_virtual_environment_sdn_vnet.vlan30
  ]
}
################################################################################################33
resource "proxmox_virtual_environment_vm" "reverse-proxy" {
  name            = "reverse-proxy.sureau.ch"
  description     = "Managed by Terraform"
  tags            = ["terraform", "debian", "staging"]
  node_name       = "pve-mazda"
  vm_id           = 4060
  keyboard_layout = "fr-ch"
  agent {
    enabled = true
  }
  cpu {
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }
  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }
  disk {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    import_from  = proxmox_virtual_environment_download_file.debian_13_trixie_qcow2_img.id
    interface    = "scsi0"
  }
  initialization {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    ip_config {
      ipv4 {
        address = "192.168.10.26/24"
        gateway = "192.168.10.1"
      }
    }
    user_data_file_id = "isonfs:snippets/cloud-config-ansible.yaml"
  }
  network_device {
    bridge = "vmbr0"
    model  = "virtio" # Recommandé pour Debian/Linux
  }
  depends_on = [
    proxmox_virtual_environment_sdn_zone_vlan.zone1,
    proxmox_virtual_environment_sdn_vnet.vlan40
  ]
}
################################################################################################33
resource "proxmox_virtual_environment_vm" "crm-oroboros" {
  name            = "crm-oroboros.sureau.ch"
  description     = "Managed by Terraform"
  tags            = ["terraform", "debian", "staging"]
  node_name       = "pve-opel"
  vm_id           = 3061
  keyboard_layout = "fr-ch"
  agent {
    enabled = true
  }
  cpu {
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }
  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }
  disk {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    import_from  = proxmox_virtual_environment_download_file.debian_13_trixie_qcow2_img.id
    interface    = "scsi0"
  }
  initialization {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    ip_config {
      ipv4 {
        address = "192.168.10.22/24"
        gateway = "192.168.10.1"
      }
    }
    user_data_file_id = "isonfs:snippets/cloud-config-ansible.yaml"
  }
  network_device {
    bridge = "vmbr0"
    model  = "virtio" # Recommandé pour Debian/Linux
  }
  depends_on = [
    proxmox_virtual_environment_sdn_zone_vlan.zone1,
    proxmox_virtual_environment_sdn_vnet.vlan30
  ]
}
################################################################################################33
resource "proxmox_virtual_environment_vm" "crm-phenomen" {
  name            = "crm-phenomen.sureau.ch"
  description     = "Managed by Terraform"
  tags            = ["terraform", "debian", "staging"]
  node_name       = "pve-opel"
  vm_id           = 3062
  keyboard_layout = "fr-ch"
  agent {
    enabled = true
  }
  cpu {
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }
  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }
  disk {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    import_from  = proxmox_virtual_environment_download_file.debian_13_trixie_qcow2_img.id
    interface    = "scsi0"
  }
  initialization {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    ip_config {
      ipv4 {
        address = "192.168.10.16/24"
        gateway = "192.168.10.1"
      }
    }
    user_data_file_id = "isonfs:snippets/cloud-config-ansible.yaml"
  }
  network_device {
    bridge = "vmbr0"
    model  = "virtio" # Recommandé pour Debian/Linux
  }
  depends_on = [
    proxmox_virtual_environment_sdn_zone_vlan.zone1,
    proxmox_virtual_environment_sdn_vnet.vlan30
  ]
}


################################################################################################33
resource "proxmox_virtual_environment_vm" "dev-mon" {
  name            = "mon"
  description     = "Managed by Terraform"
  tags            = ["terraform", "debian", "staging"]
  node_name       = "pve-opel"
  vm_id           = 9999
  keyboard_layout = "fr-ch"
  agent {
    enabled = true
  }
  cpu {
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }
  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }
  disk {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    import_from  = proxmox_virtual_environment_download_file.debian_13_trixie_qcow2_img.id
    interface    = "scsi0"
  }
  initialization {
    datastore_id = proxmox_virtual_environment_storage_nfs.iso-repo.id
    ip_config {
      ipv4 {
        address = "192.168.10.98/24"
        gateway = "192.168.10.1"
      }
    }
    user_data_file_id = "isonfs:snippets/cloud-config-ansible.yaml"
  }
  network_device {
    bridge = "vmbr0"
    model  = "virtio" # Recommandé pour Debian/Linux
  }
}



resource "proxmox_virtual_environment_download_file" "debian_13_trixie_qcow2_img" {
  content_type = "import"
  datastore_id = "isonfs"
  node_name    = "pve-mazda"

  # Utilisation d'une version datée précise au lieu de 'latest'
  url = "https://cloud.debian.org/images/cloud/trixie/20260316-2418/debian-13-genericcloud-amd64-20260316-2418.qcow2"

  # On inclut la date dans le nom du fichier pour éviter les conflits en cas de mise à jour future
  file_name = "debian-13-trixie-20260316-genericcloud-amd64.qcow2"

  # Le checksum permet à OpenTofu de vérifier que le fichier est complet et n'a pas changé
  checksum           = "0e5edfbe49b0cca779a4a7dc9738f34c92e3ff481ee1f7d5c4e93e180654fe275eb8c96397224c6ca04a2910eaaed27489f431573ebe4cb5412ef257888b2b18"
  checksum_algorithm = "sha512"
}


