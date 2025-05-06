# /srv/salt/role/webserv.sls

# - Define the web server role -
#
include:
  - langs.python
  - langs.java
  - services.apache
