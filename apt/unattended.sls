# This enables unattended-upgrades on minions
unattended:
  pkg.installed:
    - name: unattended-upgrades
    - require:
      {% if grains['id'] == 'master' %}
      - pkg: bsd-mailx
      {% else %}
      - pkg: ssmtp
      {% endif %}
      - file: /etc/apt/apt.conf.d/10periodic
      - file: /etc/apt/apt.conf.d/50unattended-upgrades

/etc/apt/apt.conf.d/10periodic:
  file.managed:
    - source: salt://apt/conf/10periodic

/etc/apt/apt.conf.d/50unattended-upgrades:
  file.managed:
    - source: salt://apt/conf/50unattended-upgrades

# On minions, we don't need ssmtp since master has a MTA
{% if grains['id'] == 'master' %}
mailx:
  pkg.installed:
    - name: bsd-mailx
{% else %}
ssmtp:
  pkg:
    - installed

# Symlink ssmtp as to look like mailx is installed
/usr/local/bin/mail:
  file.symlink:
    - target: /usr/sbin/ssmtp

{% if salt['cmd.run']('grep -o {0} {1}'.format(
  grains['host'], '/etc/ssmtp/ssmtp.conf')) != grains['host']: %}
# Update ssmtp.conf to reflect hostname in From:
/etc/ssmtp/ssmtp.conf:
  file.managed:
    - name: /etc/ssmtp/ssmtp.conf
    - source: salt://apt/conf/ssmtp.conf
    - mode: 0644
    - require:
      - pkg: ssmtp

update_ssmtp_conf_hostname:
  file.sed:
    - name: /etc/ssmtp/ssmtp.conf
    - before: 'localhost'
    - after: '{% print grains['host'] %}-mailer.domain.tld'
    - limit: '^hostname='
{% endif %}
{% endif %}
