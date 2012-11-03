# Add ssh key to root account so it can deploy latest salt states
root:
  file.managed:
    - name: /root/.ssh/id_rsa
    - source: salt://git_keys/id_rsa
    - mode: 600
    - makedirs: True

# Master users:
suscov:
  user.present:
    - fullname: Stas Suscov
    - shell: /bin/bash
    - home: /home/suscov
    - groups:
      - sudo
  file.directory:
    - name: /home/suscov/.ssh
    - user: suscov
    - group: suscov
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
    - require:
      - user: suscov
  ssh_auth.present:
    - user: suscov
    - source: salt://users/keys/suscov.id_dsa.pub
    - require:
      - file: suscov
