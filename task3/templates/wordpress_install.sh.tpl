#!/bin/bash

until (apt update); do
  echo "Sleeping 10s"
  sleep 10
done

apt upgrade -y
apt install -y wordpress

cat <<EOF> /etc/apache2/sites-available/wordpress.conf
<VirtualHost *:80>
        ServerAdmin webmaster@example.com
        DocumentRoot /usr/share/wordpress

        Alias /wp-content /var/lib/wordpress/wp-content
        <Directory /usr/share/wordpress>
            Options FollowSymLinks
            AllowOverride Limit Options FileInfo
            DirectoryIndex index.php
            Require all granted
        </Directory>
        <Directory /var/lib/wordpress/wp-content>
            Options FollowSymLinks
            Require all granted
        </Directory>

        ErrorLog /var/log/apache2/error.log
        CustomLog /var/log/apache2/access.log combined
</VirtualHost>
EOF

a2dissite 000-default
a2ensite wordpress
systemctl reload apache2

cat <<EOF> /etc/wordpress/config-default.php
<?php
define('DB_NAME', '${db_name}');
define('DB_USER', '${db_user}');
define('DB_PASSWORD', '${db_pass}');
define('DB_HOST', '${db_host}');
define('WP_CONTENT_DIR', '/var/lib/wordpress/wp-content');
?>
EOF

cat <<EOF> /tmp/wordpress
