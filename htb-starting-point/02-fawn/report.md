# Fawn Machine 

Run a quick nmap scan to check what would pop up

```php
nmap 10.129.148.194

>Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-05-29 19:52 EDT
>Nmap scan report for 10.129.148.194
>Host is up (0.023s latency).
>Not shown: 999 closed tcp ports (conn-refused)
>PORT   STATE SERVICE
>21/tcp open  ftp
```

Port 21 is FTP so ill try this as my first point of attack

```php
ftp 10.129.148.194

>Connected to 10.129.148.194.
>220 (vsFTPd 3.0.3)
>Name (10.129.148.194:drew):
```

I don't have a login so lets look at at the assignment and come back to this

FTP stands for File Transfer Protocol
FTP runs on port 21
The version of FTP that is running on the target is `vsFTPd 3.0.3`
The type of OS that the target is running is Unix
The username to use on FTP when we don't have an account is `anonymous`
Upon logging in we get a 230 status

```php
>Name (10.129.148.194:drew): anonymous
>331 Please specify the password.
>Password: 
>230 Login successful.
```

We see a file called `flag.txt` so lets download to our machine to view its contents

```php
ftp> get flag.txt
226 Transfer complete.
32 bytes received in 00:00 (1.63 KiB/s)
```

The contents of `flag.txt`

```php
035db21c881520061c53e0536e44f815
```

We have rooted the machine.