# Master host specific monit checkers

extend:
  monit:
    service:
      - require:
        - file: /etc/monit/conf.d/app-servers
        - file: /etc/monit/conf.d/db-servers
        - file: /etc/monit/conf.d/postfix
        - file: /etc/monit/conf.d/salt-master
      - watch:
        - file: /etc/monit/conf.d/app-servers
        - file: /etc/monit/conf.d/db-servers
        - file: /etc/monit/conf.d/postfix
        - file: /etc/monit/conf.d/salt-master

/etc/monit/conf.d/app-servers:
  file.managed:
    - source: salt://monit/conf/conf.d/app-servers

/etc/monit/conf.d/db-servers:
  file.managed:
    - source: salt://monit/conf/conf.d/db-servers

/etc/monit/conf.d/postfix:
  file.managed:
    - source: salt://monit/conf/conf.d/postfix

/etc/monit/conf.d/salt-master:
  file.managed:
    - source: salt://monit/conf/conf.d/salt-master
