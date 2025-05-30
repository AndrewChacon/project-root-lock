
```php
enum4linux-ng 10.129.48.179 > enum4linux.txt
```
[*] Random Username .. 'ueevawfl'

Got it. That warning confirms it: **your version of `smbclient` no longer supports SMB1**, which is required to connect to the `Lame` box on Hack The Box.

Running recon commands

```php
nc 10.129.44.252 21
> 220 (vsFTPd 2.3.4)
```

```php
nc 10.129.44.252 22
> SSH-2.0-OpenSSH_4.7p1 Debian-8ubuntu1
```

```php
telnet 10.129.44.252 22
>Trying 10.129.44.252...
>Connected to 10.129.44.252.
>Escape character is '^]'.
>SSH-2.0-OpenSSH_4.7p1 Debian-8ubuntu1
```

```php
telnet 10.129.44.252 21
>Trying 10.129.44.252...
>Connected to 10.129.44.252.
>Escape character is '^]'.
>220 (vsFTPd 2.3.4)
```

What sticks out the most is:
Port 21 - FPT - `vsFTP 2.3.4`
Port 22 - SSH - `OpenSSH_4.7.p1`

