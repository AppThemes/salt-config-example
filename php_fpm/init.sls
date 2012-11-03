# PHP5 modules and configuration
php_stack:
  pkg.installed:
    - name: php5-fpm
  service.running:
    - name: php5-fpm
    - require:
      - pkg: php5-fpm
      - pkg: php5-gd
      - pkg: php5-mysql
      - pkg: php5-suhosin
      - pkg: php5-memcache
      - pkg: php5-mcrypt
      - pkg: php5-curl
      - pkg: php5-cli
      - pkg: php-apc
      - pkg: mysql-client
    - watch:
      - file: /etc/php5/fpm/php-fpm.conf
      - file: /etc/php5/fpm/pool.d/www.conf
      - file: /etc/php5/fpm/conf.d/apc.ini
      - file: /etc/php5/fpm/php.ini

php_gd:
  pkg.installed:
    - name: php5-gd

php_mysql:
  pkg.installed:
    - name: php5-mysql

php_suhosin:
  pkg.installed:
    - name: php5-suhosin

php_memcache:
  pkg.installed:
    - name: php5-memcache

php_mcrypt:
  pkg.installed:
    - name: php5-mcrypt

php_curl:
  pkg.installed:
    - name: php5-curl

php_cli:
  pkg.installed:
    - name: php5-cli

php_apc:
  pkg.installed:
    - name: php-apc

mysql_client:
  pkg.installed:
    - name: mysql-client

# Configuration files for php5-fpm
/etc/php5/fpm/php-fpm.conf:
  file.managed:
    - source: salt://php_fpm/php-fpm.conf
    - user: root
    - group: root
    - mode: 644

/etc/php5/fpm/pool.d/www.conf:
  file.managed:
    - source: salt://php_fpm/www.conf
    - user: root
    - group: root
    - mode: 644

/etc/php5/fpm/conf.d/apc.ini:
  file.managed:
    - source: salt://php_fpm/apc.ini
    - user: root
    - group: root
    - mode: 644

/etc/php5/fpm/php.ini:
  file.managed:
    - source: salt://php_fpm/php.ini
    - user: root
    - group: root
    - mode: 644

{% if salt['cmd.has_exec']('git') %}
wp_cli:
  git.latest:
    - name: git://github.com/wp-cli/wp-cli.git
    - rev: master
    - target: /url/lib/wp-cli
    - runas: root
    - submodules: True
    - force: False
    - require:
      - pkg: php5-cli

/usr/bin/wp:
  file.symlink:
    - target: /usr/lib/wp-cli/src/bin/wp
{% endif %}
