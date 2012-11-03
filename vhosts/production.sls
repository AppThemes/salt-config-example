include:
  - vhosts.updates_appthemes_com

# AppThemes Nginx vhost files
vhosts_production:
  service.running:
    - name: nginx
    - require:
      - pkg: nginx
      - pkg: git-core
      - file: www_root
    - watch:
      - file: appthem_es
      - file: appthemes_com
      - file: demos_appthemes_com
      - file: forums_appthemes_com

www_root:
  file.directory:
    - name: /var/www
    - makedirs: True
    - user: www-data
    - group: www-data
