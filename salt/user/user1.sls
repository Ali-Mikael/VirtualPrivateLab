# /srv/salt/user/user1.sls

# NOTE: Remember to configure password!
#       Hash the password & append it as "-password: <hash>"              

#       Keep also in mind that the "sudo group" is mostly used on debian/debian-based systems.
#       Other distros might use "wheel". Check with your distro before applying

user1:
  user.present:
    - fullname: Main User
    - shell: /bin/bash
    - home: /home/user1
    - createhome: true
    - group: sudo

