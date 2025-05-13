# /srv/salt/user/webadmin.sls

webadmin_user:
  user.present:
    - name: webadmin
    - home: /home/webadmin
    - shell: /bin/bash
    - createhome: True
    - password: {{ salt['pillar.get']('password', '') }}
    - groups:
      - www-data
      - sudo
