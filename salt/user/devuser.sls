# /srv/salt/user/devuser.sls


# NOTE: Remember to configure password!
#	Hash the password & append it as "-password: <hash>"

#	Keep also in mind that the "sudo group" is mostly used on debian/debian-based systems.  
#	Other distros might use "wheel". Check with your distro before applying
devuser:
  user.present:
    - fullname: Developer
    - shell: /bin/bash
    - home: /home/devuser
    - createhome: true
    - groups:
      - sudo 
      - docker
