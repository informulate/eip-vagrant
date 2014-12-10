#!/bin/bash
echo "Informulate is provisioning your box for eip.dev/oauth.dev"
sudo yum update kernel* -y /dev/null

echo "Downloading VBoxGuestAdditions..."
#wget -Nq -O ~/VBoxGuestAdditions_4.3.8.iso http://download.virtualbox.org/virtualbox/4.3.20/VBoxGuestAdditions_4.3.20.iso 
sudo mount -t iso9660 -o loop VBoxGuestAdditions_4.3.8.iso /mnt/

echo "Downloading EPEL and installing it..."
#wget -Nq http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo rpm -ivh epel-release-6-8.noarch.rpm
export KERN_DIR=/usr/src/kernels/`uname -r`

echo "Installing Git..."
sudo yum install git -y > /dev/null

echo "Git cloning eip.dev & oauth.dev into /var/www/html. Let git.assembla.com git clone automatically..."
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

echo "Installing phpMyAdmin..."
sudo yum install -y phpmyadmin

echo "Installing MySQL..."
sudo yum install mysql -y /dev/null
sudo yum install mysql-server -y /dev/null
echo "Creating the system startup links for MySQL and start MySQL server:"
sudo chkconfig --levels 235 mysqld on
sudo /etc/init.d/mysqld start

