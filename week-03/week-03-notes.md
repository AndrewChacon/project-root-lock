## Privilege Escalation Methodology

#### 1. User Recon

Understanding who you are in a system and what privileges you have
Knowing this can help us identify what actions we just take next
Are you a low level user? What groups are you in?

```php
whoami 
> root
```

```php
id
>uid=0(root) gid=0(root)
```

Were looking if they are in the sudo group, might have passwordless root 

#### 2. System Info

Gathering OS and kernel version info, useful for kernel exploits and version specific vulnerabilities.

```php
uname -a
>Linux lame 2.6.24-16-server #1 SMP Thu Apr 10 13:58:00 UTC 2008 i686 GNU/Linux
```

```php
cat /etc/*release
>DISTRIB_ID=Ubuntu
>DISTRIB_RELEASE=8.04
>DISTRIB_CODENAME=hardy
>DISTRIB_DESCRIPTION="Ubuntu 8.04"
```

Were looking for kernel version, OS name and version, and verifying if the system is `32-bit` or `64-bit` based

#### 3. Sudo Permission Check

Checking what we can run with sudo and see if it requires a password or not
Misconfigured sudo rules allow you to escalate directly to root

```php
sudo -l
>User root may run the following commands on this host:
>    (ALL) ALL
```

Were looking for stuff such as:
- `(ALL : ALL) NOPASSWD: ALL` = direct root
- `sudoedit` access = can often edit system files as root

#### 4. SUID Binary Hunt

SUID binaries run with the privilege of the file owner, often root
Exploiting misconfigured SUID binaries lets you run commands as root
A common vector for escalation if writable or vulnerable

```php
find / -perm -u=s -type f 2>/dev/null
>/usr/bin/passwd
>/usr/bin/mtr
>/usr/sbin/uuidd
...
```

Were looking for custom or unusual binaries in `/home`, `/opt`, `/tmp`

#### 5. Process + Cron Jobs

Identify any automated tasks we could exploit being run by root
We can exploit cron jobs by replacing writable scripts with our payloads

```php
ps aux
crontab -l
cat /etc/crontab
ls -la /etc/cron.*
```

Were looking for scripts called as root `/root/backup.sh`
Writable scripts or paths in `/etc/cron.*`
Repeating tasks in `ps aux` that interact with user controlled files

#### 6. Environment Abuse & PATH Hijacking

Checking for unsafe environment settings that could lead to PATH hijacking or more
If root runs a command like backup and its found in your writable path than our version is the one that gets ran

```php
env
>TERM=linux
>QUIET=no
>PATH=/sbin:/bin:/usr/sbin:/usr/bin
>RUNLEVEL=2
>runlevel=2
>UPSTART_EVENT=runlevel
```

```php
echo $PATH
>/sbin:/bin:/usr/sbin:/usr/bin
```

```php
ls -la /tmp
>total 28
>drwxrwxrwt  5 root     root    4096 Jun  9 16:51 .
>drwxr-xr-x 21 root     root    4096 Oct 31  2020 ..
>drwxrwxrwt  2 root     root    4096 Jun  9 16:46 .ICE-unix
>-r--r--r--  1 root     root      11 Jun  9 16:46 .X0-lock
>drwxrwxrwt  2 root     root    4096 Jun  9 16:46 .X11-unix
>-rw-------  1 tomcat55 nogroup    0 Jun  9 16:47 5681.jsvc_up
>prw-rw-rw-  1 root     root       0 Jun  9 18:18 enmfw
>-rw-r--r--  1 root     root    1600 Jun  9 16:46 vgauthsvclog.txt.0
>drwx------  2 root     root    4096 Jun  9 16:49 vmware-root
```

Were looking if `/tmp` or `.` is early in the PATH
If we can write to any directory that is early in the PATH
Any suspicious environment variables 

#### 7. Linux Capabilities

List binaries with Linux capabilities, may allow them to do things normally reserved for root
Capabilities such as `cap_setuid` and `cap_net_bind_service` for escalation

```php
getcap -r / 2>/dev/null
```

Were looking for any binaries we can execute or write to
Special powers assigned to binaries 