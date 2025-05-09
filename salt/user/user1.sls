# /srv/salt/user/user1.sls

# NOTE: Remember to configure password using pillars!

user1:
  user.present:
    - fullname: Main User
    - shell: /bin/bash
    - home: /home/user1
    - createhome: true
    - group: sudo
    - password: {{ salt['pillar.get']('password', '') }}

