# Add more static hosts bellow
salt_host:
  host.present:
    - name: salt
    - ip: 10.10.10.1

master_host:
  host.present:
    - name: master
    - ip: 10.10.10.1

staging_host:
  host.present:
    - name: staging
    - ip: 10.10.10.2
