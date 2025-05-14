# /srv/salt/role/webserv.sls

# - Define the web server -

include:
  - lang.python
  - lang.java
  - service.apache
  - user.webadmin
