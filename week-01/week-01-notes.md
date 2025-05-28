# Mastering Nmap Scanning

https://www.youtube.com/watch?v=JHAMj2vN2oU&t=33s

Understand the types of scans, flags, and use cases.
We will do scans that are basic and aggressive.
Gathering info about services and their versions to create a plan of attack.
Save these scans for future reuse and report writing. 
Firewalls, routers, proxy servers, and other security devices can impact nmap scan results

# Basic Scanning

HTB Machine Jerry: 10.129.55.151

`nmap -h` - help options for the tool
`man nmap` - access the tools documentation/manual
`nmap -V` - version info for the tool

Scanning with verbose output:
```bash
nmap -v 10.129.55.151
```

Increased verbosity output:
```bash
nmap -vv 10.129.55.151
```

Scan a single target:
Nmap will scan only the top 1000 most important ports
```bash
nmap 10.129.55.151
```

Ports scanned by Nmap will be recognized by six states:
- open - a service is waiting for connections on this port 
- closed - knocked on the door but no ones home
- filtered -  guard blocked you knock did not go through, firewall
- unfiltered - you can knock but I might not be home, cant tell port's state
- open|filtered - might be opened or filtered but we aren't certain 
- closed|filtered - can't tell if its closed or filtered

Scan multiple targets:
```bash
nmap IP_ADDR IP_ADDR IP_ADDR
```

Scan an entire subnet:
Tells nmap to scan the entire IP address network 
```bash
nmap 10.129.55.0/24
```

Scan a range of IP addresses
```bash
nmap 10.129.55.1-10
```

Scan a list of targets:
Create a text file that contain a list of IP addresses or host names to scan 
Extract list of targets from a specified file
```bash
nmap -F -iL targets.txt
```

Exclude targets from a scan:
You can exclude single hosts, ranges, or entire network blocks
```bash
nmap 10.129.55.0/24 --exclude TARGET_IP
nmap {YOUR_TARGETS} --exclude {TARGETS}

nmap -F 10.129.55.0/24 --excludefile exclude.txt
```

Selecting a network interface:
```bash
nmap -e lo 10.129.55.151
nmap -e {INTERFACE} {YOUR_TARGET}
```

Scan an IPV6 target
```bash
nmap -6 fe80::8d01:f92e:8fba:9ef9
```

Scan random targets:
Randomly generate a specified number of targets and scan them
```bash
nmap -iR 3
```

Display port state reason codes:
```bash
nmap --reason 10.129.55.151

> PORT     STATE SERVICE    REASON
> 8080/tcp open  http-proxy syn-ack
```

Only display open ports:
```bash
nmap --open 10.129.55.151
```

Trace packets:
Reveals a detailed log of every packets journey send and received
Helpful for troubleshooting connectivity issues
```bash
nmap --packet-trace 10.129.55.151
```

# Port Scanning

TCP and UPD ports on a computer range from 0-65535
port specific investigation 

Perform a fast scan:
Runs the top 100 ports instead of 1000
```bash
nmap -F 10.129.55.151
```

Scan specific ports:
Specific port, multiple ports, range of ports
You can also seek the ports by their names if you wanted to
```bash
nmap -p 139 10.129.55.151
nmap -p PORT TARGET_ADDR
nmap -p PORT,PORT,PORT TARGET_ADDR
nmap -p PORT,50-1000 TARGET_ADDR
nmap -p "*" TARGET_ADDR
```

Scan top ports: 
You determine what those top ports are, any number can be specified
```bash
nmap --top-ports 10 10.129.55.151
nmap --top-ports {NUMBER_OF_TOP_PORTS} {TARGET}
```

Perform a sequential port scan:
Seeks open ports in numerical order 
```bash
nmap -r 10.129.55.151
```

# Foundational Scanning 

Dont ping:
Tells nmap to skip the initial discovery step, helpful in dealing with hosts that have things like firewalls that prevent ping probes 
```bash
nmap -PN 10.129.55.151
```

Ping only scan:
you just want to say hello, useful for recon 
```bash
nmap -sP 10.129.55.151
nmap -sP 10.129.55.0/24
```

TCP SYN ping:
sends a SYN packet to the target and listens to a response
helpful if ICMP is blocked (a network protocol used to send error messages/optional info)
```bash
nmap -PS TARGET_ADDR
```

TCP ACK ping:
Sends TCP ACK packets to the specified hosts, discover hosts by responding to TCP connections that don't really exist. 
Can be useful when ICMP pings are blocked
```bash
nmap -PA TARGET_ADDR
```

UDP ping:
Another means of exploration, sends UDP packets to hosts aiming to get a response. 
Can be useful if TCP connections are filtered or blocked
```bash
nmap -PU TARGET_ADDR
```

SCTP INIT ping:
Discover hosts using the stream control transmission protocol, data transmission between two end points
```bash
nmap -PY TARGET_ADDR
```

ICMP ECHO ping:
Sends an standard ICMP ping to the target to check if it replies, effective on local networks ICMP packets can be transported with fewer restrictions
```bash
nmap -PE TARGET_ADDR
```

ICMP timestamp ping:
Some misconfigured systems might still respond to a timestamp request
```bash
nmap -PP TARGET_ADDR
```

ICMP address mask ping:
Can sometimes bypass firewalls configured to block standard echo requests
```bash
nmap -PM TARGET_ADDR
```

IP protocol ping:
Probing a system using different IP protocols, flexible in network exploration
```bash
nmap -PO TARGET_ADDR
```

ARP ping:
Faster than other ping methods and offers more accuracy, restricted to targets in your local subnet. Fast and accurate means to identifying live hosts. 
```bash
nmap -PR TARGET_ADDR
```

Traceroute: 
accurate, helpful in understanding the flow of packets in a network. 
```bash
nmap --traceroute TARGET_ADDR
```

Force reverse DNS resolution:
Useful in a block of IP addresses, help gain info on a network address
```bash
nmap -R TARGET_ADDR
```

Disable reverse DNS resolution:
prioritizes scan speed
```bash
nmap -n TARGET_ADDR
```

Alternative DNS lookup method:
Leverages the systems DNS resolver to grab info
```bash
nmap --system-dns HOST_NAME
```

 Manually specify DNS servers:
 Avoid having your scan look ups logged in your locally configured DNS server
```bash
nmap --dns-servers 8.8.8.8,8.8.4.4,1.1.1.1 TARGET_ADDR/24
```

# Advanced Scanning

TCP SYN scans:
it doesn't complete the three-way-handshake TCP connection
```bash
nmap -sS TARGET_ADDR
```

TCP connect scan
A probe that tries to establish a connection without stealth
```bash
nmap -sT TARGET_ADDR
```

UDP scan:
Shows results of a UDP connection, another layer of depth
```bash
nmap -sU TARGET_ADDR
```

TCP NULL scan: 
Sends out packets without TCP flags, its like sending an empty package.
A way to get a response from a system with a firewall.
The unexpected responses and revelations. 
```bash
nmap -sN TARGET_ADDR
```

TCP FIN scan:
Sets the TCP FIN bit to active when sending out packets to try and get an ACK from the target system. 
```bash
nmap -sF TARGET_ADDR
```

XMAS scan:
Sends a packet with lit up flags for FIN and PSH bits, this unique combo of flags is to get a response out of a system with a firewall 
```bash
nmap -sX TARGET_ADDR
```

TCP ACK scan:
Probes the target, if no response then the system is filtered, if there is an RST packet it is unfiltered. Considered filtered means there must be a firewall or other protection. 
```bash
nmap -sA TARGET_ADDR
```

Custom TCP scan:
Craft a TCP scan custom tailored to your needs.
Assembling your own set of flags 

IP protocol scan:
Shows protocols supported by a system, you can plan your scans based on the detected protocols. 
```bash
nmap -sO TARGET_ADDR
```

Send raw Ethernet packets: 
Jumps to the data-link layer
```bash
nmap -send-eth TARGET_ADDR
```

Send IP packets:
Alternative to sending eth packets, integrates with your local IP stack
```bash
nmap --send-ip TARGET_ADDR
```

# OS & Service Detection

TCP IP fingerprinting, identify a fingerprint left behind by a targets operating system and software versions. This feature is accurate and reliable. 

Operating system detection:
you can force it to make a guess 
```bash
nmap -O TARGET_ADDR
nmap -v -O TARGET_ADDR
nmap -O --osscan-guess TARGET_ADDR
```

Service version detection: 
Tries to reveal the software name and version for each open port encounter
```bash
nmap -sV TARGET_ADDR
nmap -sV --version-trace TARGET_ADDR
```

# Timing Options

Timing options from 0-5 each for a specific purpose
Adapt your recon needs for your scanning environment

Min & max number of parallel operations
specify the min parallel ports scans that nmap should run simultaneously 
```bash
nmap --minparallelism 100 TARGET_ADDR
nmap --maxparallelism 5 TARGET_ADDR
```

Min and max host group size
Set the min number of targets that nmap should scan in parallel
```bash
nmap --min-hostgroup 20 TARGET_ADDR/24
nmap --max-hostgroup 5 TARGET_ADDR/24
```

Initial RTT timeout:
Control round trip behavior.
Reduce packet re-transmissions due to timeouts, maybe speedup scans too 
```bash
nmap --inital-rtt-timeout 1000ms TARGET_ADDR
nmap --max-rtt-timeout 100ms TARGET_ADDR
```

Maximum retries:
control max retries for probe transmissions
```bash
nmap --max-retries 5 TARGET_ADDR
```

Set the packet TTL:
Define the TTL value in ms for the packets sent during the scan, useful for targets with slower connections. 
```bash
nmap --ttl 2s TARGET_ADDR
```

Host timeout:
Set a timeout interval for scans that get hung up from firewall responses 
maintain efficient scan ops 
```bash
nmap --host-timeout 2s TARGET_ADDR
```

Min and max scan delay:
deliberate pauses between probes, optimal scanning for rate limiting 
```bash
nmap --max-scan-delay 200s TARGET_ADDR
```

Min and max packet rate: 
Tailor the packet rate 
```bash
nmap --min-rate 50 TARGET_ADDR
nmap --max-rate 100 TARGET_ADDR
```

Defeat reset rate limits:
Counter to a restriction of rate limiting
```hash
nmap --defeat-rst-ratelimit TARGET_ADDR
```

# Navigating Firewalls

Fragmenting custom MTU for evasion:
Must be in multiples of 8
```bash
nmap -mtu 16 TARGET_ADDR
```

Decoy scanning for anonymity:
you can also manually specify what addresses you want to use as decoys
```bash
nmap -D RND:DECOY_NUMS TARGET_IP
```

Idle zombie scan:
Leverages an idle system turning it into a zombie to run scans on a target system
discreetly gather info without being detected 
```bash
nmap -sI ZOMBIE_HOST TARGET_ADDR
```

Manually specify a source port number:
You can address a specific port number as the source for all packets in the scan
Helpful against firewalls not set up to properly intercept traffic from certain ports
```bash
nmap --source-port TARGET_PORT TARGET_ADDR
```

Append random data:
Add extra data to the probes to try and avoid detection by firewalls
```bash
nmap --data-length 25 TARGET_ADDR
```

Randomize target scan order
scans randomly instead of sequentially to avoid detection 
```bash
nmap --randomize-hosts TARGET_ADDR.1-100
```

 Spoof MAC address:
 nmap book man-bypass-firewalls-ids
```bash
nmap --spoof-mac MAC_VENDOR TARGET_ADDR
nmap --spoof-mac 0 TARGET_ADDR
```

Send bad checksums:
sending packets with incorrect checksums to a specified host, get a response from a poorly configured system or used for a security audit
```bash
nmap --badsum TARGET_ADDR
```

# Nmap script engine

A powerful for creating advanced scripts that leverage the scan options nmap has. 
A library of standard scripts that exist 

Execute individual scripts:
```bash
nmap --script SCRIPT TARGET_ADDR
nmap --script whois-* TARGET_ADDR
nmap -sn --script whois-* TARGET_ADDR
nmap --traceroute --script traceroute-geolocation nmap.org
```

# Output options in Nmap

```bash
nmap -oA scan TARGET_ADDR
nmap -oA FILENAME TARGET_ADDR
```

# Display scan statistics

Reveals the status of the scan in set intervals
```bash
nmap --stats-every 2s TARGET_ADDR
```

--- 

# 🧠 Understand These Concepts

A TCP 3-way-handshake is how two hosts establish a reliable connection

SYN -> the client says hey i wanna talk
SYN-ACK -> the server says yeah lets do it
ACK -> the client says great lets talk

Every proper TCP connection starts this way

Difference between `-sS`, `-sT`, `-sU`
`sS` - SYN stealth scan, never completes the TCP handshake, most used
`-sT` - TCP connect scan, full handshake, works without root
`sU` - UDP scan, no handshake, services like DNS, SNMP, slow and noisy

How does nmap discover hosts? 
Its called a ping sweep, it doesn't scan ports just checks who's alive 
Nmap might us, ICMP echo, TCP SYN, ARP, ICMP timestamp
This is host discovery, not a port scan


---

# 🌐 Scanning Methodology

https://medium.com/@mrummanhasan/scanning-methodology-a-practical-guide-1b0b7686fb89

A quick end-to-end road-map of pentest activity using nmap

## Methodology
1. Look for live systems
2. Check for open ports
3. Banner grabbing
4. Vulnerability scan
5. Penetration test report

## 1. Check For Live Systems
We have to search for any systems that are alive in the scope of our target

```bash
nmap -sP TARGET_ADDR/24
```

Find as many hosts as you can

## 2. Check For Open Ports
Our next step is to port scan to get info on open ports running on the system

```bash
nmap TARGET_ADDR
```

## 3. Perform Banner Grabbing
Banner grabbing is used to discover the type and version of software being used on ports running as services

```bash
nmap -sV TARGET_ADDR
```

Operating system detection

```
nmap -O TARGET_ADDR
```

An aggressive scan has OS detection, version detection and other services

```bash
nmap -A TARGET_ADDR
```

## 4. Vulnerability Scan
Determine the vulnerability that exists in the host
Preexisting scripts for nmap to run 

```bash
nmap --script vuln TARGET_ADDR
```

Find existing vulnerabilities from the CVE (common vulnerabilities and exploits)
Search other vulnerability databases

## 5. Penetration Testing Report
We write down and report our findings to the client

Summary: tasks accomplished, methodology used, high level findings and recommendations
Scope Of Work: Include IP addresses tested, type of pentest ran.
Details of Findings: count discovered risks, for each finding report the threat level, vulnerability rating, and impact
Recommendations: show them solutions, mitigation's, suggestions for eliminating or reducing the vulnerability. 

---

# Web Enumeration
First ill identify the ports running on the HTB machine Jerry

```bash
nmap -T4 -p- -A -Pn 10.129.117.219
```

The goal of this scan is to scan all 65535 TCP ports, provide us with info on running services as well as their versions and the traceroute path to the host

```bash
PORT   STATE SERVICE VERSION
80/tcp open  http    Apache httpd 2.4.18 ((Ubuntu))
|_http-server-header: Apache/2.4.18 (Ubuntu)
|_http-title: Arrexel's Development Site
```

Port 80 has an Apache 2.4.19 Ubuntu server running
The default page has a title of `Arrexel's Development Site`
Its hosting some kind of platform that looks like a blog site or social media

Lets run `whatweb`, this is a tool for fingerprinting it can tell us information such as the server its running, technologies used on it, plugins or CMS versions, potential misconfigs. 

```bash
whatweb http://TARGET:PORT
whatweb 10.129.117.219
```

We get lots of useful information from scan

```bash
http://10.129.117.219 [200 OK] Apache[2.4.18], Country[RESERVED][ZZ], HTML5, HTTPServer[Ubuntu Linux][Apache/2.4.18 (Ubuntu)], IP[10.129.117.219], JQuery, Meta-Author[Colorlib], Script[text/javascript], Title[Arrexel's Development Site]
```

Specifying a port is optional, if a port is not specified it will assume:
- Port 80 for an HTTP
- Port 443 for an HTTPS

`whatweb` works using a plugin based system to detect web technologies by analyzing various components of an HTTP response.

`HTTP headers` - server, set-cookies, x-powered-by
`HTML content` - meta tags, script tags, comments, inline code
`URLs & paths` - `/wp-content`, `/admin.php`, etc.
`Cookies` - cookie names and values such as `PHPSESSID`
`Response behavior` - status codes, redirects, custom error messages
`Favicon hash` - used to identify specific frameworks/services

# Web Directory Fuzzing

`fuff` and `gobuster` are tools used for brute-forcing URLs or web paths to find resources that are hidden like files, directories and in some cases subdomains. 

## ffuf (Fuzz Faster U Fool)
- a more modern, faster tool that supports recursive fuzzing, regex matching and filters. 
- Good for fuzzing everything like paths parameters, headers, etc. 

Directory/file brute force:
```bash
ffuf -u http://target.com/FUZZ -w wordlist.txt
ffuf -u http://10.129.117.219/FUZZ -w /home/drew/tools/SecLists/Discovery/Web-Content/common.txt
```

File extension brute force:
```bash
ffuf -u http://target.com/FUZZ.php -w wordlist.txt
```

Multiple extensions:
```bash
ffuf -u http://target.com/FUZZ -w wordlist.txt -e .php,.html,.txt
```

Filtering responses:
```bash
ffuf -u http://target.com/FUZZ -w wordlist.txt -fc 404
```

Filters out any 404 not found results

Recursive fuzzing:
```bash
ffuf -u http://target.com/FUZZ -w wordlist.txt -recursion
```

`fuff` might be running on a host called `http://example.com/FUZZ` upon discovering a directory it will start the fuzz process again. 
For example:
```
http://example.com/admin/FUZZ
http://example.com/images/FUZZ
http://example.com/uploads/FUZZ
```

Helpful in automating a deep path discovery without having to restart `fuff` for each new directory that we discover.
Makes the fuzzing process more complete.
Helpful in finding admin panels, backups, or other hidden content that is deeply nested.

Fuzzing GET parameters:
```bash
ffuf -u "http://target.com/page.php?FUZZ=test" -w params.txt
```

## Gobuster
- Fast go-based tool
- quick discovery and enumeration

Directory enumeration
```bash
gobuster dir http://target.com -w wordlist.txt
```

File extension brute force
```bash
gobuster dir -u http://target.com -w wordlist.txt -x php,html,txt
```

Filtering extensions:
```bash
gobuster dir http://target.com -w wordlist.txt -t --no-error
```

Vhost/subdomain enumeration:
```bash
gobuster vhost -u http://target.com -w subdomains.txt
```

Useful for discovering virtual hosts that are configured on the same IP address
Trying to discover other domain names hosted on the same server like: 
- `admin.example.com`
- `dev.example.com`
- `staging.example.com`

Discover hidden services like admin panels, staging servers, development APIs
These subdomains may not be protected or up to date
Subdomains often have weaker auth or old versions 
Useful for bug bounties, more attack surfaces = more potential vulnerabilities

## Directory Brute Forcing vs Fuzzing

Directory brute forcing is a specific kind of fuzzing that only focuses on finding hidden directories or files on a web server by appending words to the URL path

Fuzzing is broader and more flexible, injecting input from a wordlist into any part of a request to find discoveries such as unexpected behavior, vulnerabilities, or resources. 

Analogy:
- Directory brute forcing: like knocking on every door in a building to see which rooms exist 
- Fuzzing: trying different keys in every lock, checking not only doors but also drawers, safes, and secret panels. 

--- 

# SMB and Web Enumeration 