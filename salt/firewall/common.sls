# /srv/salt/firewall/common.sls

ufw: pkg.installed

ufw_enable:
  ufw.enabled:
    - require: 
      - pkg: ufw


ufw_allow_ssh:
  ufw.allow:
    - name: OpenSSH
    - require: 
      - pkg: ufw


ufw_service:
  service.running:
    - name: ufw
    - enable: True
    - require: 
      - pkg: ufw
