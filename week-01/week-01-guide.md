# ✅ Week 1: Recon & Enumeration – Technical Plan

---
## 🎯 Primary Goals:
- Master `nmap` and its advanced scan options.
- Learn structured manual service enumeration (HTTP, SMB, FTP, etc).
- Build habits around documenting findings (commands, outputs, screenshots).
- Apply recon skills on real vulnerable machines (Jerry, Lame, Bashed).
- Deliver written reports simulating OSCP standards.

--- 
## 🧰 Tools Covered
- `nmap` – full port scans, scripts, OS detection
- `ffuf` / `gobuster` – directory fuzzing
- `smbclient` / `enum4linux-ng` – SMB/Windows recon
- `whatweb` – tech fingerprinting for HTTP
- `curl`, `nc`, `telnet` – banner grabbing
- `dig`, `nslookup`, `whois` – DNS/OSINT

--- 
# 🗓️ Daily Breakdown

--- 
## 📅 Monday – Mastering Nmap

✅ Objectives:
- Learn `nmap` command syntax and output formats.
- Practice full TCP scans, version scans, and script scans.
- Document scan types and what they're used for.

🔧 Tasks:
- Run the following scans on a target (e.g., Lame):

```bash
nmap -sS -T4 -p- -oN full-port.txt 192.168.X.X
nmap -sC -sV -oN service-scan.txt 192.168.X.X
nmap -O -oN os-detect.txt 192.168.X.X
nmap --script vuln -oN vuln-scan.txt 192.168.X.X
```

📄 Deliverables:
- `nmap-cheatsheet.md`: record commands with explanations.
- Save all outputs in `week-01/recon/`

---
## 📅 Tuesday – Web Enumeration

✅ Objectives:
- Identify HTTP ports (80, 8080, etc).
- Use web fuzzing to find hidden directories and files.
- Fingerprint web technologies.

🔧 Tasks:
- Run:

```bash
whatweb http://192.168.X.X
ffuf -u http://192.168.X.X/FUZZ -w /usr/share/wordlists/dirb/common.txt -o ffuf-output.json
gobuster dir -u http://192.168.X.X -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
```

- Check `/robots.txt`, `/server-status`,` /backup/` manually.

📄 Deliverables:
- Directory of results with filenames matching target.
- Note any upload pages, login panels, default credentials.

---

## 📅 Wednesday – SMB & Windows Enumeration

✅ Objectives:
- Identify SMB/NetBIOS ports (139, 445).
- Enumerate shares, users, policies.
- Explore files from unauthenticated shares.

🔧 Tasks:
- Run:

```bash
enum4linux-ng 192.168.X.X
smbclient -L \\\\192.168.X.X\\
smbclient \\\\192.168.X.X\\<sharename>
```

- Explore shares using `cd`, `get`, `ls` in `smbclient`.

📄 Deliverables:
- `enum4linux.txt` saved.
- Notes on share contents and any credentials or config files found.

---
## 📅 Thursday – Manual Banner Grabbing + OSINT

✅ Objectives:
- Understand the basics of manual service fingerprinting.
- Learn how to extract useful info from service headers.
- Practice DNS lookups and domain intelligence tools.

🔧 Tasks:
- Run:

```bash
nc 192.168.X.X 80
telnet 192.168.X.X 21
curl -I http://192.168.X.X
dig example.com
whois example.com
nslookup example.com
```

📄 Deliverables:
- Collection of service headers.
- Any useful domain info (owner, DNS servers, subdomains).

---

## 📅 Friday – Hack HTB: Jerry (Foothold & Report)

✅ Objectives:
- Apply full recon process on `Jerry`.
- Gain low privilege shell.
- Start documenting in report format.

🔧 Tasks:
- Run full recon.
- Exploit Tomcat (hint: WAR upload via manager).
- Capture `user.txt`.

📄 Deliverables:
- `jerry-report.md`:
	- Summary of recon
	- Exploitation steps
	- Commands used
	- Screenshot of shell + flag

---
## 📅 Saturday – Hack HTB: Lame (Foothold & Report)

✅ Objectives:
- Apply recon to SMB box.
- Exploit service (unauthenticated RCE).
- Document exploitation.

🔧 Tasks:
- Enumerate shares.
- Use `smbclient` to explore.
- Try public exploits (e.g., `ms08_067` if available).

📄 Deliverables:
- `lame-report.md` with same structure as above.

---
## 📅 Sunday – Reflection + Finalization

✅ Objectives:
- Review everything.
- Finish incomplete tasks or reports.
- Write a weekly summary of your struggles, strengths, and lessons.

🔧 Tasks:
- Create `week-01/notes.md`:
	- Tools learned
	- Commands memorized
	- Challenges faced
	- What to repeat/practice more
- Update `ego-log.md` journal with your honest evaluation.

## 🔚 End-of-Week Checklist
 - Scanned and documented 2+ machines with `nmap`
 - Used web fuzzers (`ffuf`, `gobuster`) successfully
 - Enumerated SMB with `enum4linux-ng` and `smbclient`
 - Rooted Jerry and Lame (user + root flags)
 - Wrote 2 full reports
 - Created `notes.md` and updated `ego-log.md`
 