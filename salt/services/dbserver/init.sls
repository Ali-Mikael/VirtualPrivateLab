# /srv/salt/dbserver/init.sls

# - Install mysql -
#
mysql_pkg:
  pkg.installed:
    - name: mysql-server

# - mysql daemon enabled/up&runnning -
#
sql_service:
  service.running:
    - name: mysql
    - enable: True
    - require: 
      - pkg: mysql_pkg
