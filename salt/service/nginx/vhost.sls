# /srv/salt/service/nginx/vhost.sls

include:
  - service.nginx


# Manage the file in /nginx/sites-available/
/etc/nginx/sites-available/webserv1:
  file.managed:
    - source: salt://service/nginx/files/webserv1.conf
    - user: root
    - group: root
    - mode: 644


# Symlink from -available to -enabled 
/etc/nginx/sites-enabled/webserv1:
  file.symlink:
    - target: /etc/nginx/sites-available/webserv1
    - force: True


# Manage document roots

webserv1_document_root:
  file.directory:
    - name: /var/www/webserv1/html
    - user: vagrant
    - group: vagrant
    - mode: 755
    - makedirs: True


/var/www/webserv1/html/index.html:
  file.managed:
    - source: salt://service/nginx/files/index.html
    - user: vagrant
    - group: vagrant
    - mode: 644
    - require: 
      - file: webserv1_document_root


# Restart nginx after applying vhost config
nginx:
  service.running:
    - reload: True
    - watch:
      - file: /etc/nginx/sites-available/webserv1
