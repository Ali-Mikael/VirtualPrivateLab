# /srv/salt/firewall/webserv.sls

# - Making sure firewall is properly installed by first running firewall/init.sls -
#
include:
  - firewall


# - Enable and start firewalld -
#
firewalld_service:
  service.running:
    - name: firewalld
    - enable: True


# - Allow SSH -
#
allow_ssh:
  module.run:
    - name: firewalld.add_service
    - zone: public
    - service: ssh
    - permanent: True
    - unless: "firewall-cmd --zone=public --list-services | grep -w 'ssh'"
    - require:
      - service: firewalld_service


# - Allow HTTP -
#
allow_http:
  module.run:
    - name: firewalld.add_service
    - zone: public
    - service: http
    - permanent: True
    - unless: "firewall-cmd --zone=public --list-services | grep -w 'http'"
    - require:
      - service: firewalld_service


# - Allow HTTPS -
#
allow_https:
  module.run:
    - name: firewalld.add_service
    - zone: public
    - service: https
    - permanent: True
    - unless: "firewall-cmd --zone=public --list-services | grep -w 'https'"
    - require:
      - service: firewalld_service


# - Reload firewalld to apply changes (safe fallback with cmd.run) -
#
firewalld_reload:
  cmd.run:
    - name: firewall-cmd --reload
    - onlyif: "systemctl is-active --quiet firewalld"
    - onchanges:
      - module: allow_ssh
      - module: allow_http
      - module: allow_https

