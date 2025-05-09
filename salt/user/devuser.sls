# /srv/salt/user/devuser.sls


# NOTE: Remember to configure password in /srv/pillar/user/devuser/init.sls
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
