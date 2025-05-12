# /srv/salt/service/apache/kill.sls


kill_apache:
  service.dead:
    - name: apache2
    - enable: False

