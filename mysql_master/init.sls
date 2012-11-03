# MySQL (master) package are relevant changes
mysql_master:
  pkg.installed:
    - name: mysql-server
  service.running:
    - name: mysql
    - require:
      - pkg: mysql-server
    - watch:
      - file: /etc/mysql/my.cnf
      - file: /etc/mysql/conf.d/appthemes_custom.cnf
  mount.mounted:
    - name: /mnt/db
    - device: /dev/xvdc
    - fstype: ext3
    - mkmnt: True
    - opts:
      - defaults

# Configuration files for db
/etc/mysql/my.cnf:
  file.managed:
    - source: salt://mysql_master/my.cnf
    - user: root
    - group: root
    - mode: 644
/etc/mysql/conf.d/appthemes_custom.cnf:
  file.managed:
    - source: salt://mysql_master/appthemes_custom.cnf
    - user: root
    - group: root
    - mode: 644
