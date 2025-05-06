# /srv/salt/top.sls

base:

  # Define roles for minions
  # ------------------------

  'devbox':
    - role.devbox

  'web-serv':
    - role.webserv

  'db-serv':
    - role.dbserv

