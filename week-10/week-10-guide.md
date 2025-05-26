# 🧪 Week 10: Full OSCP Mock Exam Simulation

> _“No hand-holding. No walkthroughs. No excuses. Just you and the box. This is war.”_

This week is your **final exam simulation** — a high-pressure, OSCP-style environment that replicates the actual test conditions.

---

## 🎯 Mission Objectives
- Complete a full exam-style box rooting scenario:
    - 🔐 1 Buffer Overflow machine
    - 🐧 1 Linux box
    - 🪟 1 Windows box
    - ✍️ Full professional report with screenshots and proof
- Complete everything in **24 hours or less**
- Operate **completely independently**: no walkthroughs, no external help, no ChatGPT

---

## 🛠 Tools Allowed
- Any tools or scripts you would have access to during the real OSCP
- Your notes, cheat sheets, custom scripts
- Your own reports, past writeups
- No internet walkthroughs or live guidance

---

## 🧪 Exam Setup (Simulated Structure)

|Box Type|Challenge|Examples (HTB/Custom)|
|---|---|---|
|💥 Buffer Overflow|Manual exploit, get shell|`Brainpan` or `Vulnserver`|
|🐧 Linux|Exploit → privesc → root.txt|`Postman`, `Beep`|
|🪟 Windows|Exploit → privesc → root.txt|`Bastion`, `Netmon`|

_Note: Choose any three machines you've not done recently (or reset previously solved boxes) to simulate the exam under pressure._

---

## 🗓️ Day-by-Day Execution

---

### 📅 Monday — Buffer Overflow Challenge

**Objective:**  
Perform a full BOF attack from scratch

**Steps:**
- Fuzz the service
- Find the EIP offset
- Inject shellcode
- Get reverse shell
- Document step-by-step

**Deliverables:**
- `bof-report.md`
- `exploit.py` with working shellcode
- Screenshot of shell with `whoami`

---

### 📅 Tuesday — Linux Target

**Objective:**  
Exploit → Enumerate → Privilege Escalation → Flag

**Steps:**
- Nmap → service enum → exploit
- Get user shell
- Use linPEAS, manual recon
- Privesc with cronjobs/SUID/etc.

**Deliverables:**
- `linux-report.md`
- Commands and reasoning documented
- Proof: `cat /root/root.txt`

---

### 📅 Wednesday — Windows Target

**Objective:**  
SMB/HTTP → Exploit → PrivEsc → SYSTEM

**Steps:**
- Use SMB enum, WinRM, BloodHound
- Get initial shell
- Use `winPEAS`, `accesschk`, or manual enum
- Privesc via service misconfig or token abuse

**Deliverables:**
- `windows-report.md`
- Screenshot of SYSTEM
- Privesc notes + methodology

---

### 📅 Thursday — Report Writing Day

**Objective:**  
Write a full **OSCP-style report** that documents all steps
**Structure:**
- Intro, Scope, Methodology
- Target 1: Exploit → Shell → Privesc → Proof
- Target 2: ...
- Buffer Overflow: ...
- Conclusion + Lessons Learned

**Format:**
- `rootlock-mockexam-report.pdf` (or .md if preferred)

---

### 📅 Friday–Sunday (Optional) — Second Attempt or Debrief

- Retry failed box or attempt alternate mock exam
- Debrief your experience
- Compare time spent, errors, and flow
- Add to `study-log.md`:
    - What broke your momentum?
    - Where did you stall?
    - Where did you shine?

---

## ✅ Final Checklist

-  Completed 3 full boxes: BOF, Linux, Windows
-  Rooted each box with screenshots
-  Full commands and logic recorded
-  OSCP-style report written
-  study-log updated with final reflections
-  Learned how you'd perform under pressure
