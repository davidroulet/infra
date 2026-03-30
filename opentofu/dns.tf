locals {
  # 1. Toujours des accolades { } pour chaque valeur
  sites_publics = {
  }

  # 2. Ici aussi, on transforme l'IP simple en objet
  sites_prives_rp = {
    "mon" = { ip = "192.168.10.98", port = 3000}
    "pve01" = { ip = "192.168.10.91", port = 8006, proto = "https" }
  }

  # 3. Pareil pour le DNS direct
  dns_direct = {
  }
}

# --- Génération du fichier CoreDNS ---
resource "local_file" "coredns_zone" {
  filename = "../ansible/roles/coredns/templates/db.sureau.ch.j2"
  content  = <<EOT
$ORIGIN sureau.ch.
@       3600 IN SOA dns.sureau.ch. admin.sureau.ch. ( ${formatdate("YYYYMMDDhh", timestamp())} 7200 3600 1209600 3600 )
@       3600 IN NS  dns.sureau.ch.

dns     IN A   192.168.10.28
traefik IN A   192.168.10.26

; --- Services passant par le Reverse Proxy ---
%{ for name, config in merge(local.sites_publics, local.sites_prives_rp) ~}
${name} IN A   192.168.10.26
%{ endfor ~}

; --- Services en accès direct ---
%{ for name, config in local.dns_direct ~}
${name} IN A   ${config.ip}
%{ endfor ~}
EOT
}


# --- Génération de la conf Traefik  ---
resource "local_file" "traefik_dynamic_conf" {
  filename = "../ansible/roles/traefik/templates/dynamic_conf.yml.j2"
  content  = <<EOT
tls:
  certificates:
    - certFile: /etc/traefik/certs/local.crt
      keyFile: /etc/traefik/certs/local.key

http:
  # On définit le transport pour ignorer les certificats auto-signés internes
  serversTransports:
    ignore-ssl:
      insecureSkipVerify: true

  routers:
%{ for name, config in merge(local.sites_publics, local.sites_prives_rp) ~}
    ${name}-router:
      rule: "Host(`${name}.sureau.ch`)"
      service: ${name}-service
      entryPoints: ["web", "websecure"]
      tls: {}
%{ endfor ~}

  services:
%{ for name, config in merge(local.sites_publics, local.sites_prives_rp) ~}
    ${name}-service:
      loadBalancer:
%{ if lookup(config, "proto", "http") == "https" ~}
        serversTransport: ignore-ssl
%{ endif ~}
        servers:
          - url: "${lookup(config, "proto", "http")}://${config.ip}:${lookup(config, "port", 80)}"
%{ endfor ~}
EOT
}

# --- Enregistrements Publics Infomaniak ---
resource "infomaniak_record" "public_cnames" {
  for_each  = local.sites_publics
  zone_fqdn = "sureau.ch."
  type      = "CNAME"
  source    = each.key
  target    = "wedelia.ch."
}