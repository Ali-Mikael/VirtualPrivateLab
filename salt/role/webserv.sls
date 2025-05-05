# /srv/salt/role/webserv.sls

# - Web server role -
#
include:
  - langs.python
  - langs.java
  - services.apache
  - firewall.webserv
