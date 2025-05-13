# /srv/salt/service/nginx/vhost.sls

include:
  - user.webadmin
  - service.nginx


# Manage the virtual host config file
/etc/nginx/sites-available/webserv1:
  file.managed:
    - source: salt://service/nginx/files/webserv1.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx


# Enable site by symlinking it to sites-enabled 
/etc/nginx/sites-enabled/webserv1:
  file.symlink:
    - target: /etc/nginx/sites-available/webserv1
    - force: True
    - require:
      - file: /etc/nginx/sites-available/webserv1


# Manage document roots
/var/www/webserv1/html:
  file.directory:
    - user: webadmin
    - group: www-data
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
    - require:
      - user: webadmin


# Deploy and manage initial index.html
/var/www/webserv1/html/index.html:
  file.managed:
    - source: salt://service/nginx/files/index.html
    - user: webadmin
    - group: www-data
    - mode: 644
    - require: 
      - file: /var/www/webserv1/html


# Reload nginx upon changes to virtual host config
nginx:
  service.running:
    - reload: True
    - watch:
      - file: /etc/nginx/sites-available/webserv1
