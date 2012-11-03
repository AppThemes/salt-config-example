# AppThemes SaltStack

base:
  '*':
    - hosts
    - userland
    - apt_sources
    - apt.unattended
    - monit
  'stage*':
    - salt_minion
    - nginx
    - php_fpm
    - nfs.client
    - git_keys
    - vhosts.production
    - ssh.enabled
    - firewall.internal
    - monit.app
  'jenkins*':
    - jenkins
    - salt_minion
    - nginx
    - git_keys
    - ssh.disabled
    - firewall.internal
    - monit.app
  'db*':
    - salt_minion
    - mysql_master
    - ssh.enabled
    - firewall.internal
    - monit.db
  'dbs*':
    - salt_minion
    - mysql_slave
    - ssh.enabled
    - firewall.internal
    - monit.db
  'memcache*':
    - salt_minion
    - memcache
    - ssh.enabled
    - firewall.internal
    - monit.memcache
  'storage*':
    - salt_minion
    - nfs.server
    - ssh.enabled
    - firewall.internal
    - monit.nfs
  'master*':
    - users.master
    - salt_master
    - salt_minion
    - firewall.external
    - postfix
    - ssh.master
    - monit.master
