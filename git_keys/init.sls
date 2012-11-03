# AppThemes Git Deployment Keys
git_keys:
  pkg.installed:
    - name: git-master
  file.managed:
    - name: /var/www/.ssh/id_rsa
    - source: salt://git_keys/id_rsa
    - user: www-data
    - group: www-data
    - mode: 600
    - require:
      - file: git_keys_dir

known_hosts:
  file.managed:
    - name: /var/www/.ssh/known_hosts
    - source: salt://git_keys/known_hosts
    - user: www-data
    - group: www-data
    - mode: 644
    - require:
      - file: git_keys_dir

git_keys_dir:
  file.directory:
    - name: /var/www/.ssh
    - makedirs: True
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group
    - require:
      - pkg: git-core
      - pkg: nginx
