# /srv/salt/firewall/common.sls


# - UFW install -
#
ufw: pkg.installed


# - Making a hole in the fw for SSH -
#
ufw_allow_ssh:
  ufw.allow:
    - name: OpenSSH
    - require:
      - pkg: ufw

# - Allowing netdata traffic on its respective port-
#
ufw_allow_netdata:
  ufw.allow:
    - name: 19999/tcp

# - Ensuring firewall is enabled -
#
ufw_enable:
  ufw.enabled:
    - require: 
      - pkg: ufw
