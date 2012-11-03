# Database hosts specific monit checkers

extend:
  monit:
    service:
      - require:
        - file: /etc/monit/conf.d/mysql
      - watch:
        - file: /etc/monit/conf.d/mysql

/etc/monit/conf.d/mysql:
  file.managed:
    - source: salt://monit/conf/conf.d/mysql
