server {

	listen 80;
	server_name demos.appthemes.com;
	root /var/www/demos.appthemes.com;

	include conf.d/php5-fpm.conf;
	include conf.d/restrictions.conf;
	include conf.d/wordpress-ms.conf;
}


server {

	listen 443;
	server_name demos.appthemes.com;
	root /var/www/demos.appthemes.com;

	ssl on;
	ssl_certificate /etc/nginx/ssl/certs/appthemes.appthemes.com.crt;
	ssl_certificate_key /etc/nginx/ssl/private/appthemes.appthemes.com.key;

	include conf.d/php5-fpm.conf;
	include conf.d/restrictions.conf;
	include conf.d/wordpress-ms.conf;
}
