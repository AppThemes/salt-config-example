# Postfix MTA
postfix:
  pkg:
    - installed
    - names:
      - postfix
      - libsasl2-modules
  service:
    - running
    - reload: True
    - require:
      - pkg: postfix
    - watch:
      - file: /etc/postfix/main.cf
      - file: /etc/postfix/sasl_passwd
      - file: /etc/postfix/virtual

# Config for core
/etc/postfix/main.cf:
  file.managed:
    - source: salt://postfix/main.cf

/etc/postfix/sasl_passwd:
  file.managed:
    - source: salt://postfix/sasl_passwd
    - user: root
    - group: root
    - mode: 600

  cmd.wait:
      - name: postmap /etc/postfix/sasl_passwd
      - user: root
      - watch:
        - file: /etc/postfix/sasl_passwd
