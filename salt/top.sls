# /srv/salt/top.sls

base:
  'minion01':
    - role.devbox
  'minion02':
    - role.webserv
  'minion03':
    - role.db
  '*':
    - common.ssh
    - common.git

