#Creating website 
mkdir /var/www/localhost && touch /var/www/localhost/index.php
echo "<?php phpinfo(); ?>" > /var/www/localhost/index.php

#Access website
chown www-data -R /var/www/*
chown 755 -R /var/www/*

#Setup Nginx
service nginx start
mv ./tmp/nginx.conf etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

#Setup SSL

#Setup Wordpress 

#Setup MySQL
#service mysql start


#Setup PHPmyAdmin
#service php7.3-fpm start


#general restart
#service mysql restart
service nginx restart
#service php7.3-fpm restart
