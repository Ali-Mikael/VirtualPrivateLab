# /srv/salt/firewall/db.sls

# Ensure firewall is installed
include:
  - firewall 


# Enable and start firewalld
firewalld_service:
  service.running:
    - name: firewalld
    - enable: True


# Allow MySQL port 3306
allow_mysql:
  module.run:
    - name: firewalld.add_port
    - zone: public
    - port: 3306/tcp
    - permanent: True
    - unless: "firewall-cmd --zone=public --list-ports | grep -w '3306/tcp'"
    - require:
      - service: firewalld_service


# Allow SSH
allow_ssh:
  module.run:
    - name: firewalld.add_service
    - zone: public
    - service: ssh
    - permanent: True
    - unless: "firewall-cmd --zone=public --list-services | grep -w 'ssh'"
    - require:
      - service: firewalld_service


# Reload firewalld to apply changes
firewalld_reload:
  cmd.run:
    - name: firewall-cmd --reload
    - onlyif: "systemctl is-active --quiet firewalld"
    - onchanges:
      - module: allow_mysql
      - module: allow_ssh

