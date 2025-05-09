# /srv/salt/firewall/init.sls

# Install firewalld
install_firewalld:
  pkg.installed:
    - pkgs:
      - firewalld
      - python3-firewall 
