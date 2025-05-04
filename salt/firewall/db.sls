# /srv/salt/firewall/db.sls

# - firewall.init will download UFW, allow SSH and enable it -
#
include:
  - firewall.init


# - Allowing the DB traffic -
#
allow_mysql:
  ufw.allow:
    - name: 3306/tcp

