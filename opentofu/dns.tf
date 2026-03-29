locals {
  sites_web = {
    "crm"   = "192.168.10.31"
    "cloud" = "192.168.10.36"
    "rp"  = "192.168.10.26"
    "auth" = "192.168.10.33"
  }
    internal_dns = {
    "pve01" = "192.168.10.91"      
  }
}


resource "local_file" "coredns_zone" {
  filename = "../ansible/roles/coredns/templates/db.sureau.ch.j2"
  content  = <<EOT
$ORIGIN sureau.ch.
@       3600 IN SOA dns.sureau.ch. admin.sureau.ch. ( ${formatdate("YYYYMMDDhh", timestamp())} 7200 3600 1209600 3600 )
@       3600 IN NS  dns.sureau.ch.

dns     IN A   192.168.10.28
traefik IN A   192.168.10.26

; Sites vers le Reverse Proxy
%{ for name, ip in local.sites_web ~}
${name} IN A   192.168.10.26
%{ endfor ~}
; Sites vers l ip
%{ for name, ip in local.internal_dns ~}
${name} IN A   ${ip}
%{ endfor ~}

EOT
}

resource "local_file" "traefik_dynamic_conf" {
  filename = "../ansible/roles/traefik/templates/dynamic_conf.yml.j2"
  content  = <<EOT
tls:
  certificates:
    - certFile: /etc/traefik/certs/local.crt
      keyFile: /etc/traefik/certs/local.key


http:
  routers:
%{ for name, ip in local.sites_web ~}
    ${name}-router:
      rule: "Host(`${name}.sureau.ch`)"
      service: ${name}-service
      entryPoints:
        - web
        - websecure
      tls: {}
%{ endfor ~}

  services:
%{ for name, ip in local.sites_web ~}
    ${name}-service:
      loadBalancer:
        servers:
          - url: "http://${ip}:80"
%{ endfor ~}
EOT
}


resource "infomaniak_record" "public_cnames" {
  for_each  = local.sites_web
  zone_fqdn = "sureau.ch."
  type      = "CNAME"
  source    = "${each.key}"
  target    = "wedelia.ch." 
}