# /srv/salt/services/docker/init.sls

# - Install docker -
#
docker: 
  pkg.installed:
    - name: docker.io



# - Ensure docker is enabled and running -
#
docker_service:
  service.running:
    - name: docker
    - enable: true
    - require:
      - pkg: docker
