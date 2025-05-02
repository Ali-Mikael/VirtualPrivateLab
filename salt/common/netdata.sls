# - Netdata install -
#
# /srv/salt/common/netdata.sls

netdata:
  pkg.installed:
    - name: netdata

# - Ensure Netdata service is running and enabled -
#
netdata_service:
  service.running:
    - name: netdata
    - enable: True
    - require:
      - pkg: netdata

# (Optional) Ensure the configuration file is managed (if you need a custom config)
# Make sure to provide a custom netdata.conf in your files folder (e.g. salt://common/files/netdata/netdata.conf)
#
#/etc/netdata/netdata.conf:
#  file.managed:
#    - source: salt://common/files/netdata/netdata.conf
#    - user: root
#    - group: root
#    - mode: 644
#    - require:
#      - pkg: netdata_package

