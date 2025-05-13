# /srv/salt/role/devbox.sls

# - Define the developer workstation - 

include:
  - lang
  - tool
  - service.docker
  - common.ssh
  - common.git
  - user.devuser
