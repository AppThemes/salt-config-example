# NFS Server states
nfs_server:
  pkg.installed:
    - name: nfs-kernel-server
  service.running:
    - name: nfs-kernel-server
    - require:
      - pkg: nfs-kernel-server
    - watch:
      - file: server_nfs_kernel_server
      - file: server_nfs_common
      - file: idmapd_conf
  mount.mounted:
    - name: /mnt/nfs
    - device: /dev/xvdc
    - fstype: ext3
    - mkmnt: True
    - opts:
      - defaults

update_exports:
  cmd.run:
    - name: exportfs -ra
    - require:
      - pkg: nfs-kernel-server
    - watch:
      - file: server_exports

server_nfs_kernel_server:
  file.managed:
    - name: /etc/default/nfs-kernel-server
    - source: salt://nfs/server/nfs-kernel-server
    - user: root
    - group: root
    - mode: 644

server_nfs_common:
  file.managed:
    - name: /etc/default/nfs-common
    - source: salt://nfs/server/nfs-common
    - user: root
    - group: root
    - mode: 644

server_exports:
  file.managed:
    - name: /etc/exports
    - source: salt://nfs/server/exports
    - user: root
    - group: root
    - mode: 644

idmapd_conf:
  file.managed:
    - name: /etc/idmapd.conf
    - source: salt://nfs/server/idmapd.conf
    - user: root
    - group: root
    - mode: 644
