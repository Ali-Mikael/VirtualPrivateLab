# /srv/salt/service/apache/init.sls

include:
  - service.nginx.kill

# Apache install
apache2:
  pkg.installed


# Enable & run
apache_service:
  service.running:
    - name: apache2
    - enable: True
    - require:
      - pkg: apache2


# Managing the index file
/var/www/html/index.html:
  file.managed:
    - source: salt://service/apache/files/index.html
    - user: www-data
    - group: www-data
    - mode: 644
    - require:
      - pkg: apache2
