# /srv/salt/service/mariadb/init.sls


# Install mariadb
#
mariadb_install:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - mariadb-client


# Ensure service is running
#
mariadb_service:
  service.running:
    - name: mariadb
    - enable: True
    - require:
      - pkg: mariadb_install
