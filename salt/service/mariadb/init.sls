# /srv/salt/service/mariadb/init.sls


# Necessary dependency install (for preseeding)
debconf-utils:
  pkg.installed


# Preseed the root password. (to be done before db install)
set_mariadb_root:
  debconf.set:
    - name: mariadb-server
    - data:
        'mysql-server/root_password': {'type': 'password', 'value': {{ salt['pillar.get']('mysql_root', '') }} }
        'mysql-server/root_password_again': {'type': 'password', 'value': {{ salt['pillar.get']('mysql_root', '') }} }
    - require:
      - pkg: debconf-utils

# Install mariadb
#
mariadb_install:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - mariadb-client
    - require:
      - debconf: set_mariadb_root

# Ensure service is running
#
mariadb_service:
  service.running:
    - name: mariadb
    - enable: True
    - require:
      - pkg: mariadb_install
