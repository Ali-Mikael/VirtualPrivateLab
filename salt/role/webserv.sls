# /srv/salt/role/webserv.sls

# - Define the web server role -
#
include:
  - lang.python
  - lang.java
  - service.apache
