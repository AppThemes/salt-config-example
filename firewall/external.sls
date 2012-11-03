# Firewall rules for external hosts
# Check https://help.ubuntu.com/community/UFW for refernce

firewall:
  service.running:
    - name: ufw
    - enable: True
    - watch:
      - file: ufw_conf
      - file: ufw_rules
      - file: ufw_rules_ipv6

ufw_conf:
  file.managed:
    - name: /etc/ufw/ufw.conf
    - source: salt://firewall/conf/ufw.conf

ufw_rules:
  file.managed:
    - name: /lib/ufw/user.rules
    - source: salt://firewall/conf/external.user.rules

ufw_rules_ipv6:
  file.managed:
    - name: /lib/ufw/user6.rules
    - source: salt://firewall/conf/external.user6.rules
