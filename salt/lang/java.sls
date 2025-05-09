# /srv/salt/lang/java.sls

# java install
java_pkg:
  pkg.installed:
    - name: openjdk-17-jdk
