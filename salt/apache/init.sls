ApacheInstall:
  pkg.installed:
    - name: apache2


ApacheService:
  service.running:
    - name: apache
