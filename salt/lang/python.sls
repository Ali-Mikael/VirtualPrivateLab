# /srv/salt/lang/python.sls

# python/pip install
python:
  pkg.installed:
    - name: python3

pip:
  pkg.installed:
    - name: python3-pip
