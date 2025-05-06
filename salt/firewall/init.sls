# /srv/salt/firewall/init.sls

# - Installing firewalld module -
#
install_firewalld:
  pkg.installed:
    - pkgs:
      - firewalld
      - python3-firewall 
