# /srv/salt/service/nginx/kill.sls


kill_nginx:
  service.dead:
    - name: nginx
    - enable: False
