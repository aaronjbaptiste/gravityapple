#!/usr/bin/env bash

echo "-- Starting the install process"

echo "-- Update Packages"
sudo apt-get update

echo "-- Installing basic tools, like vim"
sudo apt-get install -y vim curl wget git

echo "-- Mysql server default password"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "-- Installing apache"
sudo apt-get install -y apache2
sudo a2enmod rewrite
sudo a2enmod deflate
sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

echo "-- Setting document root"
sudo mkdir /vagrant/public
sudo rm -rf /var/www/html
sudo ln -fs /vagrant/public /var/www/html

sudo apt-get update

sudo apt-get install -y php5 php5-mysql php5-mcrypt php5-curl php5-gd libapache2-mod-php5

sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini

echo "-- Installing mysql"
sudo apt-get install -y mysql-server

echo "-- Restarting apache"
sudo service apache2 restart

echo "-- Installing composer"
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

echo "-- Finished, ready to dev."