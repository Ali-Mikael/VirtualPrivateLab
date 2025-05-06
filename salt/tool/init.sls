# /srv/salt/tool/init.sls

include:
  - tool.htop
  - tool.tmux
  - tool.httpie
  - tool.build-essential
  - tool.nmap
  - tool.tcpdump
