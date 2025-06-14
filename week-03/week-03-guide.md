# 🐧 Week 3: Linux Privilege Escalation

---
## 🎯 Objectives
- Learn how to identify local privilege escalation vectors on Linux
- Understand common misconfigurations (SUIDs, PATH hijacks, cron jobs)
- Learn how to use `linpeas`, `pspy`, and manual techniques together
- Practice chaining low-priv shells → full root access
- Create your own PrivEsc checklist and `cheatsheet`

---

## 🛠 Tools to Master

| Tool                               | Purpose                                            |
| ---------------------------------- | -------------------------------------------------- |
| `linpeas.sh`                       | Automated local enumeration (enumerate everything) |
| `pspy64`                           | Monitor running processes and cron jobs            |
| `sudo -l`                          | Check sudo privileges                              |
| `find`                             | Find SUID/SGID binaries                            |
| `getcap`                           | Look for binaries with unusual capabilities        |
| `env`, `which`, `echo $PATH`       | Analyze environment variables                      |
| `awk`, `nano`, `vi`, `less`, `cat` | Manual file inspection                             |

---

## 🧠 Manual Techniques You’ll Practice
- Abusing `sudo` misconfigurations
- Exploiting weak cron jobs (world-writable scripts)
- PATH hijacking
- Exploiting SUID binaries and unusual permissions
- Reading sensitive files (e.g., backups with passwords)
- Escalating with custom scripts, reverse shells, or `nc`

---

## 💻 Machines to Root

|Machine|Focus|
|---|---|
|**Beep**|PATH hijack, cron jobs|
|**Nibbles**|SUID binary abuse, weak service|
|**Postman**|SSH key exposure, privilege script|

---

# 🗓️ Daily Breakdown

---

### 📅 Monday – PrivEsc Methodology + Checklist

#### ✅ Objectives:
- Learn structured methodology
- Understand types of vectors
#### 🔧 Tasks:
- Study this flow:
    1. `whoami`, `id`
    2. `uname -a`, `cat /etc/*release`
    3. `sudo -l`
    4. `find / -perm -u=s -type f 2>/dev/null`
    5. `ps -aux`, `crontab -l`, `/etc/crontab`
    6. `env`, `$PATH`, `ls -la /tmp`
    7. `getcap -r / 2>/dev/null`
- Build your own `privesc-checklist.md` based on the flow

---

### 📅 Tuesday – SUID + PATH Hijacking Practice

#### ✅ Objectives:
- Learn to identify and abuse dangerous SUID binaries
- Use PATH hijacking to escalate
#### 🔧 Tasks:
- Find SUIDs:

```bash
find / -perm -4000 -type f 2>/dev/null
```

- Find writable scripts in cron:

```bash
find / -type f -writable -exec ls -l {} \; 2>/dev/null | grep cron
```

- Craft a fake binary and place in `/tmp` to hijack execution
#### 📄 Deliverables:
- Practice example of `PATH` hijack
- Document SUID binary and exploitation result

---

### 📅 Wednesday – Use linPEAS + Manual Follow-up

#### ✅ Objectives:
- Run `linpeas.sh`, interpret output manually
- Learn how to spot weak configs
#### 🔧 Tasks:
- Run:

```
./linpeas.sh > linpeas-output.txt`
```

- Review sections:
    - SUID/SGID
    - sudo rights
    - cron jobs
    - unusual capabilities
    - PATH/env
- Cross-reference `GTFOBins`:  [https://gtfobins.github.io/](https://gtfobins.github.io/)
#### 📄 Deliverables:
- Extract 2+ potential vectors from linPEAS output and test them

---

### 📅 Thursday – Monitor with pspy & Exploit Cron Jobs

#### ✅ Objectives:
- Learn to monitor system activity in real-time
- Exploit cron jobs that call world-writable scripts
#### 🔧 Tasks:
- Run:

```
./pspy64
```

- Look for repeated scripts or binaries being called
- Replace called binary with your reverse shell or `bash -i`
#### 📄 Deliverables:
- Log of the cron job
- Reverse shell proof
- Notes on timing + persistence

---

### 📅 Friday – Root Beep (PrivEsc)

#### ✅ Objective:
- Apply everything you’ve learned on Beep
- Root via misconfig or service
#### 🔧 Tasks:
- Full local enumeration
- Escalate to root with one of the methods from this week
#### 📄 Deliverables:
- `beep-report.md`

---

### 📅 Saturday – Root Nibbles + Postman

#### ✅ Objective:
- Practice back-to-back privilege escalations
- Use `sudo -l`, SUID, weak config to gain root
#### 🔧 Tasks:
- Root `Nibbles`
- Root `Postman`
- Use `linpeas`, `sudo -l`, `pspy`, or custom analysis
#### 📄 Deliverables:
- `nibbles-report.md`
- `postman-report.md`

---

### 📅 Sunday – Weekly Review + Cheatsheet

#### ✅ Objective:
- Finalize notes, build permanent cheatsheet
- Reflect on failures and wins
#### 🔧 Tasks:
- Build `privesc-cheatsheet.md` with examples + payloads
- Update `notes.md` with command logs
- Update `ego-log.md` with:
    - Which methods felt intuitive?
    - Which vectors do I still struggle with?
    - What did I miss and later discover?

---

## ✅ End-of-Week Checklist
-  Rooted Beep, Nibbles, Postman
-  3 full reports written (manual privesc paths)
-  linPEAS and pspy logs interpreted correctly
-  PATH hijack or cron exploit reproduced
-  `privesc-cheatsheet.md` created
-  `ego-log.md` updated with honest self-assessment
