# Monit service and config files
monit:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: monit
      - file: /etc/monit/monitrc
      - file: /etc/monit/conf.d/fs
      - file: /etc/monit/conf.d/salt-minion
      - file: /etc/monit/conf.d/system
      - file: /etc/monit/conf.d/ufw
      - file: /etc/monit/conf.d/ssh
    - watch:
      - file: /etc/monit/monitrc
      - file: /etc/monit/conf.d/fs
      - file: /etc/monit/conf.d/salt-minion
      - file: /etc/monit/conf.d/system
      - file: /etc/monit/conf.d/ufw
      - file: /etc/monit/conf.d/ssh

/etc/monit/monitrc:
  file.managed:
    - source: salt://monit/conf/monitrc

# General monit checkers
# For host specific checkers check this file directory root

/etc/monit/conf.d/fs:
  file.managed:
    - source: salt://monit/conf/conf.d/fs

/etc/monit/conf.d/salt-minion:
  file.managed:
    - source: salt://monit/conf/conf.d/salt-minion

/etc/monit/conf.d/system:
  file.managed:
    - source: salt://monit/conf/conf.d/system

/etc/monit/check-ufw.sh:
  file.managed:
    - source: salt://monit/conf/check-ufw.sh
    - mode: 755
/etc/monit/conf.d/ufw:
  file.managed:
    - source: salt://monit/conf/conf.d/ufw
    - require:
      - file: /etc/monit/check-ufw.sh

/etc/monit/conf.d/ssh:
  file.managed:
    - source: salt://monit/conf/conf.d/ssh
