# /srv/salt/common/ssh.sls

# - SSH server install -
#
ssh-server:
  pkg.installed:
    - name: openssh-server



# - Managing the SSHd config file -
#
/etc/ssh/sshd_config:
  file.managed:
    - source: salt://common/files/ssh/sshd_config
    - require:
      - pkg: ssh-server


# - Service enabled / up & running -
#
sshd:
  service.runing:
    - name: ssh
    - enable: True
    - require:
      - pkg: ssh-server
    - watch:
      - file: /etc/ssh/sshd_config
      
