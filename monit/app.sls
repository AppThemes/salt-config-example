# Application hosts specific monit checkers

extend:
  monit:
    service:
      - require:
        - file: /etc/monit/conf.d/nginx
        - file: /etc/monit/conf.d/php-fpm
      - watch:
        - file: /etc/monit/conf.d/nginx
        - file: /etc/monit/conf.d/php-fpm

/etc/monit/conf.d/nginx:
  file.managed:
    - source: salt://monit/conf/conf.d/nginx

/etc/monit/conf.d/php-fpm:
  file.managed:
    - source: salt://monit/conf/conf.d/php-fpm
