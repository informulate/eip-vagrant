#!/bin/bash
echo "Informulate is provisioning your box for eip.dev/oauth.dev"

echo "Installing Git..."
sudo yum install git -y > /dev/null

echo "Git cloning eip.dev & oauth.dev into /var/www/html. Let git.assembla.com git clone automatically..."
echo "git.assembla.com,64.250.188.42 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAr06hg4ep5IKc85rjYZkEmer+BMkpLfsYi7iOMWytiqyow0jqMiVg7t32a4WW0349QV4rmfcMg5ULuIP//mBjSb2G1jSmqPvWx4JCzZLKu3nmsx1YdBWmVvn/qyVLQ5E+NCSkJJORKqIIgiL1WuAEaxUODYmBExwv1eMZWBpyeKZrrsBEmogKt2Q+igQ31+rb1fQI9/hDE+SktOpT9sWJ9brSDgsQNXAtV52DFDA8mzq7FL+4TbLjDoDdK7v3LFYn2cnN2kD57gW8qvP6V6mrkjc6I2aCNBHwdcIynUQ8HKdU+Sd4u7pZsCCK7odgPCcM5Jj+/PladSR8+DCtvs6JWw==" > ~/.ssh/known_hosts
git clone git@git.assembla.com:eiprewrite.client.git -b develop ~/eip.dev
git clone git@git.assembla.com:eiprewrite.server.git -b develop ~/oauth.dev

echo "Installing Apache..."
sudo yum install httpd -y /dev/null
echo "Creating the system startup links and starting Apache..."
sudo chkconfig --levels 235 httpd on
sudo /etc/init.d/httpd start

echo "Installing PHP..."
sudo yum install php -y /dev/null
echo "Install MySQL support in PHP..."
sudo yum install php-mysql -y /dev/null
echo "Installing common PHP modules..."
sudo yum install php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-mssql php-snmp php-soap php-tidy curl curl-devel -y > /dev/null
echo "Installing PHP opcode cacher for caching and optimizing PHP intermediate code..."
sudo yum install php-pecl-apc -y /dev/null
echo "Restarting Apache..."
sudo /etc/init.d/httpd restart

echo "Importing the RPMforge GPG Key..."
yum install -y phpmyadmin

echo "Installing MySQL..."
sudo yum install mysql -y /dev/null
sudo yum install mysql-server -y /dev/null
echo "Creating the system startup links for MySQL and start MySQL server:"
sudo chkconfig --levels 235 mysqld on
sudo /etc/init.d/mysqld start
