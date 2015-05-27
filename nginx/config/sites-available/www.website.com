# website vhost
server {

  listen                  80;
  listen                  443 ssl spdy;
  
  server_name             www.website.com;
  root                    /var/www/website.com;


  # this runs last
  location / {

    try_files $uri $uri/ @rewrites;
    
  }


  # put stray rewrites here
  location @rewrites {
  
    # if nothing matches anywhere
    rewrite ^ /index.php?$args last;
    
  }


  include global.d/*.conf;
  include global/wp-ms-subdomain.conf;
  include global/php.conf;
    
}
