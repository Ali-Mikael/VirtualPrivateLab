# /srv/salt/firewall/devbox.sls

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
# Change the port value if SSH runs on a non-standard port
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


# - Reload firewalld to apply changes (fallback to cmd.run if needed) -
#
firewalld_reload:
  cmd.run:
    - name: firewall-cmd --reload
    - onlyif: "systemctl is-active --quiet firewalld"
    - onchanges:
      - module: allow_ssh

