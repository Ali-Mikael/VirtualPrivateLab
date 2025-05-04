# /srv/salt/firewall/webserv.sls


# - firewall.init will download UFW, allow SSH and enable it -
#
include:
  - firewall.init

# - Allowing DB and http/https traffic here -
#
allow_mysql:
  ufw.allow:
    - name: 3306/tcp


allow_http:
  ufw.allow:
    - name: 80/tcp


allow_https:
  ufw.allow:
    - name: 443/tcp
