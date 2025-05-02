# /srv/salt/firewall/db.sls

include:
  - firewall.common

allow_mysql:
  ufw.allow:
    - name: 3306/tcp

