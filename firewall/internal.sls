# Firewall rules for internal hosts
# Check https://help.ubuntu.com/community/UFW for refernce

firewall:
  service.running:
    - name: ufw
    - enable: True
    - watch:
      - file: ufw_conf
      - file: ufw_rules

ufw_conf:
  file.managed:
    - name: /etc/ufw/ufw.conf
    - source: salt://firewall/conf/ufw.conf

ufw_rules:
  file.managed:
    - name: /lib/ufw/user.rules
    - source: salt://firewall/conf/internal.user.rules
