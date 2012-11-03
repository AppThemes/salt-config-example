# NFS host specific monit checkers

extend:
  monit:
    service:
      - require:
        - file: /etc/monit/conf.d/nfs
      - watch:
        - file: /etc/monit/conf.d/nfs

/etc/monit/conf.d/nfs:
  file.managed:
    - source: salt://monit/conf/conf.d/nfs
