
## Initial Target Scan 

```php
nmap -T4 -p- -A TARGET_IP
```

## Web Enumeration

```php
ffuf -u http://TARGET_IP/FUZZ -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt -of html -o ffuf_scan.html -fc 404
```

```php
gobuster dir -u http://TARGET_IP -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt --no-error -o gobuster.txt
```

## SMB Enumeration

```php
enum4linux-ng TARGET_IP > enum4linux.txt
```

```php
smbclient -L \\\\TARGET_IP\\ 
```

```php
crackmapexec smb TARGET_IP
```