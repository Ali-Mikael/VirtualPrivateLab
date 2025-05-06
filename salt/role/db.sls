# /srv/salt/role/db.sls

# - Define the database server role -
#
include:
  - service.dbserver
  - lang.python

