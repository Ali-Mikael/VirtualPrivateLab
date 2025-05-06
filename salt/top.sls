# /srv/salt/top.sls

base:

  # Defining minion specific states
  # -------------------------------

  'devbox':
    - role.devbox

  'web-serv':
    - role.webserv

  'db-serv':
    - role.db

