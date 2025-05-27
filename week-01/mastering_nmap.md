# nmap nmap.org

```bash
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-05-26 23:38 EDT
Nmap scan report for nmap.org (50.116.1.184)
Host is up (0.088s latency).
Other addresses for nmap.org (not scanned): 2600:3c01:e000:3e6::6d4e:7061
rDNS record for 50.116.1.184: ack.nmap.org
Not shown: 992 filtered tcp ports (no-response)
PORT      STATE  SERVICE
22/tcp    open   ssh
25/tcp    closed smtp
53/tcp    open   domain
70/tcp    closed gopher
80/tcp    open   http
113/tcp   closed ident
443/tcp   open   https
31337/tcp closed Elite

Nmap done: 1 IP address (1 host up) scanned in 6.77 seconds
```

# nmap -sS nmap.org

```bash
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-05-26 23:38 EDT
Nmap scan report for nmap.org (50.116.1.184)
Host is up (0.090s latency).
Other addresses for nmap.org (not scanned): 2600:3c01:e000:3e6::6d4e:7061
rDNS record for 50.116.1.184: ack.nmap.org
Not shown: 992 filtered tcp ports (no-response)
PORT      STATE  SERVICE
22/tcp    open   ssh
25/tcp    closed smtp
53/tcp    open   domain
70/tcp    closed gopher
80/tcp    open   http
113/tcp   closed ident
443/tcp   open   https
31337/tcp closed Elite

Nmap done: 1 IP address (1 host up) scanned in 6.84 seconds
```

# nmap -p- nmap.org

```bash
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-05-26 23:42 EDT
Nmap scan report for nmap.org (50.116.1.184)
Host is up (0.088s latency).
Other addresses for nmap.org (not scanned): 2600:3c01:e000:3e6::6d4e:7061
rDNS record for 50.116.1.184: ack.nmap.org
Not shown: 65527 filtered tcp ports (no-response)
PORT      STATE  SERVICE
22/tcp    open   ssh
25/tcp    closed smtp
53/tcp    open   domain
70/tcp    closed gopher
80/tcp    open   http
113/tcp   closed ident
443/tcp   open   https
31337/tcp closed Elite

Nmap done: 1 IP address (1 host up) scanned in 175.82 seconds
```

# nmap -A nmap.org

```bash
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-05-26 23:44 EDT
Nmap scan report for nmap.org (50.116.1.184)
Host is up (0.092s latency).
Other addresses for nmap.org (not scanned): 2600:3c01:e000:3e6::6d4e:7061
rDNS record for 50.116.1.184: ack.nmap.org
Not shown: 992 filtered tcp ports (no-response)
PORT      STATE  SERVICE  VERSION
22/tcp    open   ssh      OpenSSH 7.4 (protocol 2.0)
| ssh-hostkey: 
|   2048 48:e0:c6:cd:14:00:00:db:b6:b0:3d:f2:0a:2a:3b:6d (RSA)
|   256 88:2b:29:00:d0:c7:81:ac:dd:f4:90:42:d2:aa:f0:5b (ECDSA)
|_  256 64:d6:39:35:04:76:1c:ba:17:f3:fd:4f:1f:b3:71:61 (ED25519)
25/tcp    closed smtp
53/tcp    open   domain   (generic dns response: NOTIMP)
| dns-nsid: 
|_  id.server: EWR
| fingerprint-strings: 
|   DNSVersionBindReqTCP: 
|     version
|_    bind
70/tcp    closed gopher
80/tcp    open   http     Apache httpd 2.4.6
|_http-title: Did not follow redirect to https://nmap.org/
|_http-server-header: Apache/2.4.6 (CentOS)
113/tcp   closed ident
443/tcp   open   ssl/http Apache httpd 2.4.6
| http-robots.txt: 6 disallowed entries 
| /favicon/*/ /search.html?* /search/?* /dist/ 
|_/dist-old/ /mailman/
|_http-favicon: Nmap Project
|_http-server-header: Apache/2.4.6 (CentOS)
|_http-title: Nmap: the Network Mapper - Free Security Scanner
|_ssl-date: TLS randomness does not represent time
| ssl-cert: Subject: commonName=insecure.com
| Subject Alternative Name: DNS:insecure.com, DNS:insecure.org, DNS:issues.nmap.com, DNS:issues.nmap.org, DNS:issues.npcap.com, DNS:issues.npcap.org, DNS:nmap.com, DNS:nmap.net, DNS:nmap.org, DNS:npcap.com, DNS:npcap.org, DNS:seclists.com, DNS:seclists.net, DNS:seclists.org, DNS:sectools.com, DNS:sectools.net, DNS:sectools.org, DNS:secwiki.com, DNS:secwiki.net, DNS:secwiki.org, DNS:svn.nmap.org, DNS:www.nmap.org
| Not valid before: 2025-05-23T09:09:38
|_Not valid after:  2025-08-21T09:09:37
| http-methods: 
|_  Potentially risky methods: TRACE
31337/tcp closed Elite
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port53-TCP:V=7.94SVN%I=7%D=5/26%Time=68353535%P=x86_64-pc-linux-gnu%r(D
SF:NSVersionBindReqTCP,1D6,"\x01\xd4\0\x06\x81\x85\0\x01\0\0\0\0\0\x01\x07
SF:version\x04bind\0\0\x10\0\x03\0\0\)\x04\xd0\0\0\0\0\x01\xab\0\x0c\x01\x
SF:a7\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
SF:0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
SF:\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
SF:0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
SF:\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
SF:0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
SF:\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
SF:0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
SF:\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
SF:0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
SF:\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
SF:0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0")%r
SF:(DNSStatusRequestTCP,E,"\0\x0c\0\0\x90\x04\0\0\0\0\0\0\0\0");
Aggressive OS guesses: Linux 5.0 - 5.4 (98%), Linux 4.15 - 5.8 (94%), Linux 5.0 - 5.5 (93%), Linux 5.1 (93%), Linux 2.6.32 - 3.13 (93%), Linux 2.6.39 (93%), Linux 5.0 (92%), Linux 2.6.22 - 2.6.36 (91%), Linux 3.10 - 4.11 (91%), Linux 3.10 (91%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 18 hops
Service Info: Host: issues.nmap.org

TRACEROUTE (using port 80/tcp)
HOP RTT      ADDRESS
1   13.12 ms _gateway (192.168.0.1)
2   13.21 ms 192.168.4.1
3   31.98 ms 32-221-232-1.bng02.brpt.ct.ip.frontiernet.net (32.221.232.1)
4   20.32 ms ae15---100.car01.wlfr.ct.frontiernet.net (172.76.21.37)
5   24.72 ms ae9---0.scr04.asbn.va.frontiernet.net (74.40.1.61)
6   36.49 ms ae24---0.cbr04.asbn.va.frontiernet.net (74.41.143.197)
7   15.61 ms ae54.edge2.NewYork6.Level3.net (4.68.10.29)
8   ...
9   20.34 ms 4.36.183.206
10  20.36 ms ae2.r01.lga01.icn.netarch.akamai.com (23.203.156.36)
11  24.83 ms ae21.r01.iad02.icn.netarch.akamai.com (23.209.165.93)
12  30.31 ms ae9.r02.ord01.icn.netarch.akamai.com (23.32.62.123)
13  80.26 ms ae1.r11.sjc01.ien.netarch.akamai.com (23.207.232.35)
14  96.46 ms ae22.gw4.scz1.netarch.akamai.com (23.203.158.53)
15  ... 17
18  82.31 ms ack.nmap.org (50.116.1.184)

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 52.83 seconds
```

# nmap -oA scans/target-scan nmap.org

# nmap -sC -sV -p open-ports nmap.org

