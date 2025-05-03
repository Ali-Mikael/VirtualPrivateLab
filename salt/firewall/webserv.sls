# /srv/salt/firewall/webserv.sls


# - firewall.common will download UFW, allow SSH and enable it -
#
include:
  - firewall.common

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
