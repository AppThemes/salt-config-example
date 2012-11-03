# Jenkins state file
jenkins:
  pkg:
    - installed
  cmd.run:
    - name: wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | sudo apt-key add -
    - unless: apt-key list | grep 'Kohsuke Kawaguchi'
    - require:
      - file: /etc/apt/sources.list.d/jenkins.list
  service.running:
    - require:
      - pkg: nginx
      - pkg: jenkins
      - pkg: git-core
      - file: /etc/nginx/sites-enabled/jenkins.domain.tld
    - watch:
      - file: /etc/default/jenkins
      - git: jenkins_config
  file.directory:
    - name: /var/lib/jenkins/.ssh
    - makedirs: True
    - user: jenkins
    - group: nogroup
    - recurse:
      - user
      - group
    - require:
      - pkg: jenkins

phpunit:
  pkg.installed:
    - name: php-pear

  {% if not salt['cmd.has_exec']('phpunit') %}
  cmd.script:
    - name: salt://jenkins/phpunit.sh
    - runas: root
  {% endif %}

phpmd:
  pkg.installed:
    - name: php-pear
  {% if not salt['cmd.has_exec']('phpmd') %}
  cmd.script:
    - name: salt://jenkins/phpmd.sh
    - runas: root
  {% endif %}

wp_tests:
  git.latest:
    - name: git://github.com/AppThemes/wordpress-tests.git
    - rev: master
    - target: /var/lib/jenkins/wp-tests
    - runas: jenkins
    - force: False
  file.managed:
    - name: /var/lib/jenkins/wp-tests/wp-tests-config.php
    - user: jenkins
    - group: nogroup
    - source: salt://jenkins/wp-tests-config.php
    - mode: 644

dos2unix:
  pkg.installed:
    - name: dos2unix

zip:
  pkg.installed:
    - name: zip

allow_sudo:
  file.managed:
    - name: /etc/sudoers.d/jenkins
    - source: salt://jenkins/sudoers
    - mode: 440

/etc/apt/sources.list.d/jenkins.list:
  file.managed:
    - source: salt://apt_sources/jenkins.list

# Nginx vhost to proxy requests for Jenkins
/etc/nginx/sites-enabled/jenkins:
  file.managed:
    - source: salt://vhosts/conf/jenkins
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: nginx

/etc/default/jenkins:
  file.managed:
    - source: salt://jenkins/config
    - user: root
    - group: root
    - mode: 644

# Add git keys so that jenkins config files can be pulled from git
jenkins_git_key:
  file.managed:
    - name: /var/lib/jenkins/.ssh/id_rsa
    - source: salt://git_keys/id_rsa
    - user: jenkins
    - group: nogroup
    - mode: 600
    - require:
      - pkg: jenkins

# Add ssh known keys file so that git wont die
jenkins_known_hosts:
  file.managed:
    - name: /var/lib/jenkins/.ssh/known_hosts
    - source: salt://git_keys/known_hosts
    - user: jenkins
    - group: nogroup
    - mode: 644
    - require:
      - pkg: jenkins

/var/lib/jenkins/.gitconfig:
  file.managed:
    - source: salt://jenkins/gitconfig
    - user: jenkins
    - group: nogroup
    - mode: 644
    - require:
      - pkg: jenkins

{% if salt['cmd.has_exec']('git') %}
jenkins_config:
  git.latest:
    - name: git@github.com:AppThemes/jenkins.git
    - rev: master
    - target: /var/lib/jenkins/workdir
    - runas: jenkins
    - submodules: True
    - force: False
    - require:
      - pkg: jenkins
      - file: jenkins_git_key
      - file: jenkins_known_hosts
{% endif %}
