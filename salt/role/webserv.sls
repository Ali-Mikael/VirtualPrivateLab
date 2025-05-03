# /srv/salt/role/webserv.sls

# - Web server role -
#
include:
  - firewall.webserv
  - services.apache
  - langs.python
  - langs.java
