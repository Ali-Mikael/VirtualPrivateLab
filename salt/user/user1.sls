# /srv/salt/user/user1.sls


user1:
  user.present:
    - fullname: Main User
    - shell: /bin/bash
    - home: /home/user1
    - groups:
      - wheel

