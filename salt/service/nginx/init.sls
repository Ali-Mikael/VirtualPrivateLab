# /srv/salt/service/nginx/init.sls

# - Install nginx -
#
install_nginx:
  pkg.installed:
    - name: nginx


# - Enable and run -
#
nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - require:
      - require:
        - pkg: nginx
