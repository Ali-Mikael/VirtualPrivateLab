# /srv/salt/apache/init.sls


# - Apache install -
# 
apache:
  pkg.installed:
    - name: apache2


# - Ensuring the service is enabled & running -
#
apache_service:
  service.running:
    - name: apache2
    - enable: True
    - require:
      - pgk: apache


# - Managing the index file -
#
/var/www/html/index.html:
  file.managed:
    - source: salt://services/apache/sites/index.html
    - user: www-data
    - group: www-data
    - mode: 644
    - require:
      - pkg: apache
