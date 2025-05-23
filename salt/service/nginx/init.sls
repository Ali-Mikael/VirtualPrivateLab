# /srv/salt/service/nginx/init.sls

include:
  - service.apache.kill

# Install nginx
install_nginx:
  pkg.installed:
    - name: nginx


# Enable and run
nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - watch: 
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/default
    - require:
        - pkg: nginx


# Managing nginx config file
/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://service/nginx/files/nginx.conf
    - user: root
    - group: root
    - mode: 640


# Managing the index file
/var/www/html/index.html:
  file.managed:
    - source: salt://service/nginx/files/index.html
    - user: root
    - group: root
    - mode: 644


# Managing the default file
default_available:
  file.managed:
    - name: /etc/nginx/sites-available/default
    - source: salt://service/nginx/files/default
    - user: root
    - group: root
    - mode: 640 


# Enabling the site by symlinking it to sites-enabled
/etc/nginx/sites-enabled/default:
  file.symlink:
    - target: /etc/nginx/sites-available/default
    - require:
      - file: default_available
