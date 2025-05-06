# /srv/salt/role/devbox.sls

# - Define the developer workstation role -
#
include:
  - langs
  - services.docker
  - common.git
  - common.ssh
