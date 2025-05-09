# /srv/salt/service/mysql/init.sls

# Install mysql
mysql:
  pkg.installed:
    - name: mysql-server

# Enable & run
sql_service:
  service.running:
    - name: mysql
    - enable: True
    - require: 
      - pkg: mysql
