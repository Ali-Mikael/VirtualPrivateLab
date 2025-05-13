# /srv/salt/service/apache/init.sls

include:
  - service.nginx.kill
  - user.webadmin


# Apache install
apache2:
  pkg.installed


# Enable & run
apache_service:
  service.running:
    - name: apache2
    - enable: True
    - reload: True
    - watch:
      - file: /etc/apache2/apache2.conf
      - file: /etc/apache2/sites-available/000-default.conf
    - require:
      - pkg: apache2


# Manage the apache2 config file
/etc/apache2/apache2.conf:
  file.managed:
    - source: salt://service/apache/files/apache2.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache2

# Manage site config file
/etc/apache2/sites-available/000-default.conf:
  file.managed:
    - source: salt://service/apache/files/000-default.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache2

# Symlink site to sites-enabled
/etc/apache2/sites-enabled/000-default.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/000-default.conf
    - force: True
    - require:
      - file: /etc/apache2/sites-available/000-default.conf


# Managing document roots
/var/www/html:
  file.directory:
    - user: webadmin
    - group: www-data
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group


# Managing the index file
/var/www/html/index.html:
  file.managed:
    - source: salt://service/apache/files/index.html
    - user: webadmin
    - group: www-data
    - mode: 644
    - require:
      - pkg: apache2
      - user: webadmin
