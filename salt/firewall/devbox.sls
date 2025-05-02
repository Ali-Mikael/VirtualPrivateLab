# /srv/salt/firewall/devbox.sls


include:
  - firewall.common

allow_mysql:
  ufw.allow:
    - name: 3306/tcp


allow_http:
  ufw.allow:
    - name: 80/tcp


allow_https:
  ufw.allow:
    - name: 443/tcp


