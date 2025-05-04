# /srv/salt/firewall/init.sls


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


# - Ensuring firewall is enabled -
#
enable_ufw:
  ufw.enabled:
    - require: 
      - pkg: ufw

