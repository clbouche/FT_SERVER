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
rm -rf /etc/nginx/sites-enabled/default

#Setup SSL/certificates
mkdir /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/localhost.key -out /etc/nginx/ssl/localhost.crt -subj "/CN=FR/SN=Paris/L=17ieme/O=42 School/OU=clbouche/CN=clbouche@student.42.fr"


#Setup MySQL
service mysql start
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO "username"@"localhost";" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#Setup PHPmyAdmin
mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-5.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin
mv ./tmp/phpmyadmin.inc.php /var/www/localhost/phpmyadmin/config.inc.php

#Setup wordpress
apt install -y curl
cd /tmp/
wget https://www.wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz -C /var/www/localhost
mv /tmp/wp-config.php /var/www/localhost/
#echo '<?php' > /var/www/localhost/wp-config.php 
#curl https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/website/wp-config.php
#vi /var/www/website/wp-config.php

#General restart
service nginx restart
service php7.3-fpm start
bash
