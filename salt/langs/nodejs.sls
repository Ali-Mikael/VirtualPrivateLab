# /srv/salt/langs/nodejs.sls

# - Install javascript -
#
nodejs:
  pkg.installed:
    - pkgs:
      - nodejs
      - npm

