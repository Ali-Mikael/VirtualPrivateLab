# /srv/salt/firewall/db.sls

# - firewall.common will download UFW, allow SSH and enable it -
#
include:
  - firewall.common


# - Allowing the DB traffic -
#
allow_mysql:
  ufw.allow:
    - name: 3306/tcp

