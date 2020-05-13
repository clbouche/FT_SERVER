#Access website
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# Generate website folder
mkdir /var/www/localhost && touch /var/www/localhost/info.php
echo "<?php phpinfo(); ?>" >> /var/www/localhost/info.php

#Setup NGINX
service nginx start
mv ./tmp/nginx.conf etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost etc/nginx/sites-enabled/localhost

#Setup SSL
mkdir etc/nginx/ssl
openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.crt -keyout /etc/nginx/ssl/localhost.key -subj "/CN=FR/SN=Paris/L=17ieme/O=42 School/OU=clbouche/CN=clbouche@student.42.fr"

#Setup MySQL
service mysql start
echo "CREATE DATABASE wordpress;"
#| mysql -u root --skip-password
echo "GRANT ALL ON wordpress.* TO 'user'@'localhost'IDENTIFIED BY 'password' WITH GRANT OPTION;"
#| mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';"
#| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"
# | mysql -u root --skip-password

#Setup PHP
mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/monsupersite/phpmyadmin
mv ./tmp/phpmyadmin.inc.php /var/www/monsupersite/phpmyadmin/config.inc.php

service nginx restart
bash
