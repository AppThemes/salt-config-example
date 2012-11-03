# Postfix MTA
postfix:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: postfix
    - watch:
      - file: /etc/postfix/main.cf

# Config for core
/etc/postfix/main.cf:
  file.managed:
    - source: salt://postfix/main.cf
    - require:
      - pkg: postfix
