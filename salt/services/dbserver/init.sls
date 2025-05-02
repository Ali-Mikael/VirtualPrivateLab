# /srv/salt/dbserver/init.sls

# - Install mysql -
#
mysql:
  pkg.installed:
    - name: mysql-server

# - mysql service enabled, up & runnning -
#
sql_service:
  service.running:
    - name: mysql
    - enable: True
    - require: 
      - pkg: mysql
