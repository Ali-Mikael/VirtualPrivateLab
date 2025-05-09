# /srv/salt/common/git

# Git install
git:
  pkg.installed:
    - name: git
