# /srv/salt/apache/init.sls


# - Apache install -
# 
apache_pkg:
  pkg.installed:
    - name: apache2


# - Ensuring the service is enabled & running -
#
apache_service:
  service.running:
    - name: apache
    - enable: True
    - require:
      - pgk: apache_pkg


# - Managing the index file -
#
/var/www/html/index.html:
  file.managed:
    - source: salt://apache/sites/index.html
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache_pkg
