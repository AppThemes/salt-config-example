apt_sources:
  cmd.run:
    - name: apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E27C0A6
    - unless: apt-key list | grep 'Launchpad PPA for Salt Stack'
    - require:
      - file: /etc/apt/sources.list
      - file: /etc/apt/sources.list.d/salt.list

/etc/apt/sources.list:
  file.managed:
    - source: salt://apt_sources/sources.list

/etc/apt/sources.list.d/salt.list:
  file.managed:
    - source: salt://apt_sources/salt.list
