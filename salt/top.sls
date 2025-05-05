# /srv/salt/top.sls

base:

  # Defining states to apply to all minions
  # ---------------------------------------
  '*'
    - common.ssh
    - common.git

  # Defining minion specific states
  # -------------------------------
  'minion01':
    - role.devbox

  'minion02':
    - role.webserv

  'minion03':
    - role.db

