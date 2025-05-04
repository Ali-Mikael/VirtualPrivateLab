# /srv/salt/firewall/devbox.sls


# - firewall.init will download UFW, allow SSH and enable it -
#
include:
  - firewall.init


# - Allowing DB traffic -
#
allow_mysql:
  ufw.allow:
    - name: 3306/tcp


# - Allowing http/https traffic -
#
allow_http:
  ufw.allow:
    - name: 80/tcp


allow_https:
  ufw.allow:
    - name: 443/tcp


