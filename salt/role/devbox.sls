# /srv/salt/role/devbox.sls

# - Define the developer workstation role -
#
include:
  - lang
  - tool
  - service.docker
  - common.ssh
  - common.git
