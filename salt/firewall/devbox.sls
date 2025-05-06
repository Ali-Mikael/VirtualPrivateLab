# /srv/salt/firewall/devbox.sls

# - Making sure firewall is properly installed by first running firewall/init.sls -
#                                
include:
  - firewall 


# - Allow SSH -
# Change "-name: ssh" to --> "-port: <number>/tcp" if using a different port for ssh 
#
allow_ssh:
  firewalld.present:
    - name: ssh
    - zone: public
    - permanent: True
    - immediate: True


# - Enable & Start -
#
enable_firewalld:
  service.running:
    - name: firewalld
    - enable: True
    - require:
      - firewalld: allow_ssh
