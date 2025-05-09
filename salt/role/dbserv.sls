# /srv/salt/role/db.sls

# - Define the database server -

include:
  - service.mariadb
  - lang.python

