# /srv/salt/firewall/init.sls

# - Installing firewalld -
#
install_firewalld:
  pkg.installed:
    - pkgs:
      - firewalld
      - python3-firewall 
