# How to use vnet


・「10.0.0.0/16」→「10.0.0.0」 ~ 「10.0.255.255」  
・「172.0.0.0/8」→「172.0.0.0」~「172.255.255.255」  
・「192.168.0.0/32」→「192.168.0.0」~「192.168.0.255」  

## Web Server
### SSH
Add port 22 in Inbound security rules
```shell-session
$ ssh -i ~/.ssh/id_rsa thara@40.115.186.105
$ sudo lsof -i -n -P
```

### Apache
```shell-session
$ sudo yum -y install httpd
$ sudo service httpd start
$ sudo chkconfig httpd on

$ ps aux
$ sudo lsof -i -n -P
```
Add port 80 in Inbound security rules
Configure DNS name label in Public IP Address

## DB Server
```shell-session
$ scp -i ~/.ssh/id_rsa ~/.ssh/id_rsa thara@40.115.186.105:~/.ssh/
$ sudo chown ~/.ssh/id_rsa thara:thara
sudo chmod 400 ~/.ssh/id_rsa

$ ssh -i ~/.ssh/id_rsa thara@172.110.1.4

```

### MySQL
 
```shell-session
$ rpm -qa | grep maria
$ sudo yum remove mariadb-libs
$ rm -rf /var/lib/mysql/

$ sudo yum localinstall http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
$ sudo yum install mysql mysql-devel mysql-server mysql-utilities
$ mysqld --version

$ sudo systemctl enable mysqld.service
$ systemctl status mysqld.service
$ sudo systemctl start mysqld.service

$ grep password /var/log/mysqld.log
root@localhost: n3VeXl!:DFyp
$ mysql_secure_installation
P@ssw0rd

$ mysql -u root -p
mysql> CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
mysql> grant all on wordpress.* to wordpress@"%" identified by 'WordpressPasswd0:' ;
mysql> flush privileges;
mysql> select user, host from mysql.user;
```

## Web Server
### PHP
```shell-session
$ sudo yum -y install php php-mysql php-mbstring
$ sudo yum -y install mysql
```
### Connect to MySQL
Add port 3306 in Inbound security rules
Source
 ip address
 default subnet ip range 172.110.0.0/24
 port ranges *
Destination
 any
 3306
 TCP

```shell-session
$ mysql -h 172.110.1.4 -u wordpress -p
```
### WordPress
```shell-session
$ wget http://ja.wordpress.org/latest-ja.tar.gz
$ tar xzvf latest-ja.tar.gz
$ cd wordpress
$ sudo cp -r * /var/www/html/
$ sudo chown apache:apache /var/www/html/ -R

$ sudo service httpd restart
```
sudo service httpd restart


DB2
172.110.2.4

vnet110
 172.110.0.0/16
default
 172.110.0.0/24 
 172.110.0.4
subnet1
 172.110.1.0/24
 172.110.1.4
subnet2
 172.110.2.0/24
 172.110.2.4


ssh -i ~/.ssh/id_rsa thara@40.115.241.75
ssh -i ~/.ssh/id_rsa thara@172.120.0.4
 vnet120
  172.120.0.0/16

test-server2
ssh -i ~/.ssh/id_rsa thara@172.120.1.4

172.120.0.4
172.120.1.4


40.115.186.105
gooner-web.japaneast.cloudapp.azure.com
172.110.0.4



ssh -i ~/.ssh/id_rsa thara@40.115.241.75


172.16.0.0/16

test
