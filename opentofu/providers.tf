terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
    infomaniak = {
      source = "infomaniak/infomaniak"
    }
    infisical = {
      # version = <latest version>
      source = "infisical/infisical"
    }
  }
}

provider "proxmox" {

  endpoint  = data.infisical_secrets.common_secrets.secrets["pve_endpoint"].value
  api_token = data.infisical_secrets.common_secrets.secrets["pve_api_token"].value
  insecure  = true
}


provider "infomaniak" {
  host  = "https://api.infomaniak.com"
  token = data.infisical_secrets.common_secrets.secrets["infomaniak_token"].value
}


provider "infisical" {
  host = "https://eu.infisical.com" 
  auth = {
    # organization_slug = "<organization slug to scope the session to sub-org>"
    universal = {
      client_id     = var.client_id
      client_secret = var.client_secret
    }
  }
}

data "infisical_secrets" "common_secrets" {
  env_slug     = "dev"
  workspace_id = var.workspace_id
  folder_path  = "/tofu/"
}