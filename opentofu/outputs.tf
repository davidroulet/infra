# 1. On regroupe toutes tes VMs dans une liste locale pour faciliter l'itération
locals {
  all_vms = [
    proxmox_virtual_environment_vm.dns,
    proxmox_virtual_environment_vm.proxy,
    proxmox_virtual_environment_vm.docker,
    proxmox_virtual_environment_vm.drive,
    proxmox_virtual_environment_vm.crm,
    proxmox_virtual_environment_vm.auth,
    proxmox_virtual_environment_vm.reverse-proxy,
    proxmox_virtual_environment_vm.crm-oroboros,
    proxmox_virtual_environment_vm.crm-phenomen,
    proxmox_virtual_environment_vm.dev-mon
  ]
}

# 2. On génère le fichier hosts.ini
resource "local_file" "ansible_inventory" {
  filename = "../ansible/inventory/hosts.ini"
  content  = <<EOT
[proxmox_vms]
%{ for vm in local.all_vms ~}
${vm.name} ansible_host=${split("/", vm.initialization[0].ip_config[0].ipv4[0].address)[0]}
%{ endfor ~}

[all:vars]
ansible_user=ansible-user
ansible_ssh_private_key_file=./ansible-user
EOT
}


