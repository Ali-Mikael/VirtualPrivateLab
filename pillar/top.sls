# /srv/salt/pillar/top.sls

base:

  '*':
    - user.user1

  'db-serv':
    - database

  'devbox':
    - user.devuser

  'web-serv':
    - user.webadmin
