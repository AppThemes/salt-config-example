# Memcache host specific monit checkers

extend:
  monit:
    service:
      - name: monit
      - require:
        - file: /etc/monit/conf.d/memcache
      - watch:
        - file: /etc/monit/conf.d/memcache

/etc/monit/conf.d/memcache:
  file.managed:
    - source: salt://monit/conf/conf.d/memcache
