# Make sure nginx is installed and up
nginx:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: nginx
      - file: /etc/nginx
      - file: /etc/nginx/htpasswd


### CONFIG FILES ###


# Configuration files for nginx
/etc/nginx:
  file.recurse:
    - source: salt://nginx/config
    - user: root
    - group: root
    - file_mode: 644

/etc/nginx/htpasswd:
  file.recurse:
    - source: salt://nginx/htpasswd
    - user: www-data
    - group: www-data
    - dir_mode: 544
    - file_mode: 444



### VHOSTS ###


# symlink the site
/etc/nginx/sites-enabled/www.website.com:
  file.symlink:
    - target: /etc/nginx/sites-available/www.website.com
    - user: www-data
    - group: www-data

# symlink another site
/etc/nginx/sites-enabled/support.website.com:
  file.symlink:
    - target: /etc/nginx/sites-available/support.website.com
    - user: www-data
    - group: www-data

