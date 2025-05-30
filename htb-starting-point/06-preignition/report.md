```php
nmap -A -sC -p- 10.129.22.204

>PORT   STATE SERVICE VERSION
>80/tcp open  http    nginx 1.14.2
>|_http-server-header: nginx/1.14.2
>|_http-title: Welcome to nginx!
```

Port 80 is very interesting, we will run `gobuster` to do some directory brute forcing
We are looking for hidden URL paths and potential files

```php
gobuster dir -u 10.129.22.204 -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt -x php

>Starting gobuster in directory enumeration mode
>===============================================================
>/admin.php            (Status: 200) [Size: 999]
```

What we get is a page for an admin login

```php
http://10.129.22.204/admin.php
```

Testing a series of default password we log in successfully
username: `admin`, password: `admin`

```php
## Admin Console Login
#### Congratulations! Your flag is: 6483bee07c1c1d57f14e5b0717503c73
```

We have rooted this machine