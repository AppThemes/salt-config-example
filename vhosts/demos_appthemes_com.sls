# demos.appthemes.com vhost
demos_appthemes_com:
  file.managed:
    - name: /etc/nginx/sites-enabled/demos.appthemes.com
    - source: salt://vhosts/conf/demos.appthemes.com
    - user: root
    - group: root
    - mode: 644
  {% if salt['cmd.has_exec']('git') %}
  git.latest:
    - name: git@github.com:AppThemes/demos.appthemes.com.git
    {% if grains['host'] == 'stage' %}
    - rev: staging
    {% else %}
    - rev: master
    {% endif %}
    - target: /var/www/demos.appthemes.com
    - runas: www-data
    - submodules: True
    - force: False
  {% endif %}
  mount.mounted:
    - name: /var/www/demos.appthemes.com/wp-content/blogs.dir
    - device: nfs:/mnt/nfs/demos/blogs.dir
    - fstype: nfs
    - mkmnt: True
    - opts:
      - _netdev,auto
