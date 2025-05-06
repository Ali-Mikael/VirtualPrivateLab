# /srv/salt/role/db.sls

# - Define the database server role -
#
include:
  - service.database
  - lang.python

