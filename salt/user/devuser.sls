# /srv/salt/user/devuser.sls


# NOTE: Remember to configure password!
# 	Use either a hash stored in this file or create it using pillars
devuser:
  user.present:
    - fullname: Developer
    - shell: /bin/bash
    - home: /home/devuser
    - createhome: true
    - groups:
      - sudo 
      - docker
    - password: {{ salt['pillar.get']('password', '') }}
