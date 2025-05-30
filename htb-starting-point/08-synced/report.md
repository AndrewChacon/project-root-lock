```php
nmap -sV -A -p- 10.129.155.6

Not shown: 65534 closed tcp ports (conn-refused)
PORT    STATE SERVICE VERSION
873/tcp open  rsync   (protocol version 31)
```

Port 873 running `rsync` version 31

```php
rsync rsync://10.129.155.6/
public         	Anonymous Share
```

we find a share for `public` and `Anonymous Share`
Lets download the `flag.txt` file from the `public` share

```php
rsync -av rsync://10.129.155.6/public/flag.txt .
receiving incremental file list
flag.txt
sent 43 bytes  received 135 bytes  27.38 bytes/sec
total size is 33  speedup is 0.19
```

View `flag.txt` contents

```php
cat flag.txt 
72eaf5344ebb84908ae543a719830519
```

We have rooted this machine.