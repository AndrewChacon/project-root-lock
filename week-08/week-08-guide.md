# 🏰 Week 8: Active Directory Part I — Initial Foothold

> _"This isn’t a box anymore. It’s a network. With structure. With hierarchy. And now you’re the chaos inside of it."_

---

## 🎯 Objectives
- Understand Active Directory fundamentals: domains, users, trusts
- Perform **AD enumeration** from a foothold
- Identify ways to **capture low-priv domain credentials**
- Gain your **first foothold** inside an AD environment
- Learn to use `BloodHound`, `rpcclient`, `smbclient`, and `kerbrute`

---

## 🛠 Tools to Master

|Tool|Purpose|
|---|---|
|`rpcclient`|Enumerate users, groups from null sessions|
|`smbclient`|Access and list shares manually|
|`crackmapexec`|Validate user/pass across domain|
|`kerbrute`|Spray usernames or passwords against Kerberos|
|`bloodhound` + `neo4j`|Visualize domain relationships|
|`nmap`, `enum4linux-ng`|Legacy enumeration|

---

## 🧠 Concepts to Learn
- Domain vs local accounts
- Common AD ports: 88, 389, 445, 636, 3268
- LDAP, SMB, Kerberos, NTLM basics
- Null sessions and anonymous enumeration
- User enumeration via Kerberos (no auth needed)

---

## 💻 Capstone Machines

|Machine|Concepts Covered|
|---|---|
|**Forest**|AD enumeration, AS-REP Roasting|
|**Blackfield**|User enumeration + password reuse|

---

## 🗓️ Daily Breakdown

---

### 📅 Monday – AD Protocols & Attack Surface Overview

#### ✅ Objectives:
- Learn what makes AD different
- Understand attack surface (Kerberos, LDAP, SMB)
#### 🔧 Tasks:
- Watch videos or read:
    - Ports and Protocols (88, 389, 445, 464, etc.)
    - What is Kerberos? Why is it exploitable?
    - How are usernames gathered?
- Update `ad-fundamentals.md` with:
    - Key ports
    - LDAP structure
    - AD user/group hierarchy

---

### 📅 Tuesday – Username Enumeration (null sessions + Kerberos)

#### ✅ Objectives:
- Enumerate users using null SMB session and Kerberos
#### 🔧 Tasks:

```bash
rpcclient -U "" <IP>
> enumdomusers
```

```bash
kerbrute userenum --dc <IP> -d domain.local users.txt
```

- Use `enum4linux-ng`, `smbclient` to list shares:

```bash
smbclient -L //<IP> -U anonymous
```

#### 📄 Deliverables:
- List of discovered users
- Notes on output from rpcclient, kerbrute, enum4linux

---

### 📅 Wednesday – Password Spraying & Share Hunting

#### ✅ Objectives:
- Test discovered users for weak passwords
- Access public or misconfigured shares
#### 🔧 Tasks:

```bash
crackmapexec smb <IP> -u users.txt -p 'Password1'
```

```bash
smbclient //IP/share -U "user%pass"
```

- Try uploading web shells or pulling sensitive files
#### 📄 Deliverables:
- Proof of successful access to share or low-priv shell
- Record of password spray results

---

### 📅 Thursday – BloodHound & Graph-Based Enumeration

#### ✅ Objectives:
- Learn to collect data for BloodHound
- Visualize privilege paths and attack chains
#### 🔧 Tasks:
- From foothold:

```bash
Invoke-BloodHound -CollectionMethod All -ZipFile bloodhound.zip
```

- Upload `bloodhound.zip` to your attacker box
- In Kali:

```
bloodhound
```

- Analyze for:
    - `Can RDP`
    - `AdminTo`
    - `GenericAll`
#### 📄 Deliverables:
- Screenshot of a potential privilege escalation path
- `bloodhound-report.md`

---

### 📅 Friday – Root Forest

#### ✅ Objectives:
- Enumerate users
- Exploit AS-REP Roasting
- Crack ticket offline and login with valid creds
#### 🔧 Tasks:

```bash
GetNPUsers.py domain.local/ -no-pass -usersfile users.txt
```

- Crack hash with:

```bash
john hash.txt --wordlist=/usr/share/wordlists/rockyou.txt
```

- Reuse credentials on SMB/WinRM
#### 📄 Deliverables:
- `forest-report.md`

---

### 📅 Saturday – Root Blackfield

#### ✅ Objectives:
- Use all skills so far: enum, spray, password reuse
- Get domain user → loot files or elevate
#### 🔧 Tasks:
- Enumerate users via SMB + Kerberos
- Spray default passwords
- Look for credentials in user profile shares
#### 📄 Deliverables:
- `blackfield-report.md`

---

### 📅 Sunday – Reflection & AD Cheatsheet

#### ✅ Objectives:
- Create cheat resources for AD enumeration
- Review tools and tactics
#### 🔧 Tasks:
- `ad-enum-cheatsheet.md`:
    - Ports, tools, commands
    - Common privilege paths
- Update `notes.md`, `ego-log.md`

---

## ✅ End-of-Week Checklist

-  Rooted Forest and Blackfield
-  Used `rpcclient`, `kerbrute`, and `crackmapexec`
-  Used BloodHound and identified attack path
-  Recovered at least 1 password via AS-REP Roasting
-  All reports and cheatsheets completed
-  Fully updated ego-log