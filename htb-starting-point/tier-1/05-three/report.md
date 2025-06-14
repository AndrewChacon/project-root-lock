From our scan we picked up 2 points of interest:
- Port 22 - `OpenSSH 7.6p1`
- Port 80 - `Apache httpd 2.4.29`

Lets enumerate the website

```php
ffuf -u http://10.129.156.133/FUZZ -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt -of html -o ffuf_scan.html -fc 404
```

```php
wfuzz -c -w /home/drew/tools/SecLists/Discovery/DNS/subdomains-top1million-5000.txt -u "http://thetoppers.ht"b -H "Host: FUZZ.thetoppers.htb" --hw 1036 -t 5
```

```
gobuster dir -u http://TARGET_IP -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt --no-error -o gobuster.txt
```