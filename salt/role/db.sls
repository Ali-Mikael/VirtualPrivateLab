# /srv/salt/role/db.sls

# - Define the database server role -
#
include:
  - services.dbserver
  - langs.python

