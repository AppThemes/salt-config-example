# PHP5 modules and configuration
php_stack:
  pkg.installed:
    - name: php5-fpm
  service.running:
    - name: php5-fpm
    - watch:
      - file: /etc/php5/fpm/php-fpm.conf
      - file: /etc/php5/fpm/pool.d/www.conf
      - file: /etc/php5/fpm/conf.d/apc.ini
      - file: /etc/php5/fpm/conf.d/suhosin.ini
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

php_pear:
  pkg.installed:
    - name: php-pear



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

/etc/php5/fpm/conf.d/suhosin.ini:
  file.managed:
    - source: salt://php_fpm/suhosin.ini
    - user: root
    - group: root
    - mode: 644

/etc/php5/fpm/php.ini:
  file.managed:
    - source: salt://php_fpm/php.ini
    - user: root
    - group: root
    - mode: 644

/usr/bin/wp:
  file.managed:
    - source: http://wp-cli.org/builds/phar/wp-cli.phar
    - source_hash: md5=b92c863f0de5ae58405f58d7d50d7084
    - user: root
    - group: root
    - mode: 755
