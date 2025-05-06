# /srv/salt/role/db.sls

# - Database role -
#
include:
  - services.dbserver
  - langs.python
