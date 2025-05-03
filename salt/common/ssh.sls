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
    - user: root
    - group: root
    - mode: 600
    - require:
      - pkg: ssh-server


# - Service enabled / up & running. Will also look out for changes in the config file -
#
sshd:
  service.running:
    - name: ssh
    - enable: True
    - reload: True
    - watch:
      - file: /etc/ssh/sshd_config
    - require:
      - pkg: ssh-server
