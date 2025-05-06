# /srv/salt/firewall/webserv.sls

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


# - Allow web traffic -
#
allow_http:
  firewalld.present:
    - name: http
    - zone: public
    - permanent: True
    - immediate: True

allow_https:
  firewalld.present:
    - name: https
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
      - firewalld: allow_http
      - firewalld: allow_https
