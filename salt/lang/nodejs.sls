# /srv/salt/lang/nodejs.sls

# Install javascript
nodejs:
  pkg.installed:
    - pkgs:
      - nodejs
      - npm

