# /srv/salt/lang/python.sls

# - python/pip install -
#
py_pkg:
  pkg.installed:
    - name: python3

pip:
  pkg.installed:
    - name: python3-pip
