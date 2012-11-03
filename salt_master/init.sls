# Salt Master states file
salt_master:
  pkg.installed:
    - name: salt-master
  service.running:
    - name: salt-master
    - require:
      - pkg: salt-master
    - watch:
      - file: /etc/salt/master

# Configuration file for master
/etc/salt/master:
  file.managed:
    - source: salt://salt_master/conf
    - user: root
    - group: root
    - mode: 644
