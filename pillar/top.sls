# /srv/salt/pillar/top.sls

base:

  'db-serv':
    - database

  'devbox':
    - user.devuser
