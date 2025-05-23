## 🔥 Phase 0: Define the OSCP Endgame

**To pass OSCP**, you must:

-   Root 3/5 machines in 24h exam (at least 2 manually)
-   Do a buffer overflow by hand
-   Write and submit a detailed professional report
-   Operate without hints, walkthroughs, or hand-holding

### 🔥 10-Week Balanced Bluelock Build

**Ideal for:** Deep, high-quality prep with aggressive pacing but recovery windows.

#### 📅 Weekly Breakdown (Summary)

| Week | Focus                                     | Capstone Labs           |
| ---- | ----------------------------------------- | ----------------------- |
| 1    | OSCP Structure, Recon, Nmap, Bash         | HTB: Lame, Bashed       |
| 2    | Enumeration (Linux + Windows)             | HTB: Legacy, Optimum    |
| 3    | Linux PrivEsc                             | HTB: Beep, Nibbles      |
| 4    | Windows PrivEsc, PowerShell               | HTB: Netmon, Bastion    |
| 5    | Buffer Overflow Mastery                   | Vulnserver + THM Lab    |
| 6    | Web Vulns: LFI, Uploads, Auth Bypass      | HTB: Shocker, Nineveh   |
| 7    | SQLi, RCE, XSS                            | HTB: Traverxec, Writeup |
| 8    | Active Directory Part I (User → Domain)   | HTB: Forest             |
| 9    | AD Part II (Kerberoast, DCSync, Pivoting) | HTB: Active, Reel2      |
| 10   | Full OSCP Mock Exam                       | Self-timed, full report |

# 🔥 Bluelock OSCP Program: 10 Weeks to War Mode

**🎯 Goal:** Crush the OSCP exam by end of summer.

📆 STRUCTURE OVERVIEW
Duration: 10 Weeks
Daily Commitment: 3–4 hours minimum
Goal: Simulate the OSCP grind while hardening every offensive skill
Method: Learn → Apply → Reflect → Document → Evolve
Style: NO walkthroughs. Manual-first hacking. Every flag reported.

🔁 WEEKLY FLOW
| Day | Focus |
| --------- | --------------------------------------- |
| Monday | Learn new topic (theory, tools, vulns) |
| Tuesday | Practice techniques & tools manually |
| Wednesday | Hack 1 HTB machine (aligned with topic) |
| Thursday | Post-exploitation / PrivEsc |
| Friday | Document everything (report, notes) |
| Saturday | Bonus box or repeat missed concepts |
| Sunday | Reflect, clean up notes, prep next week |

🧰 REQUIRED TOOLS
Install via the bluelock-setup.sh script I gave you:
nmap, ffuf, gobuster, sqlmap, hydra, linpeas, pspy
enum4linux-ng, smbclient, bloodhound, crackmapexec, impacket
gdb, pwndbg, msfvenom, nc, chisel, python3 -m http.server
burpsuite, whatweb, nikto, wfuzz
rockyou.txt, seclists, wordlists

```bash
week-XX/
├── recon/
├── exploits/
├── privesc/
├── screenshots/
├── notes.md
├── report-machine1.md
├── report-machine2.md
└── README.md

```

🔟 WEEK PLAN — FULL DETAIL
🧭 Week 1 – Recon & Enumeration
| Tools | nmap, whatweb, gobuster, ffuf, dig, nslookup, enum4linux-ng, smbclient |
| Machines | Jerry, Lame, Bashed |
| Skills | Port scanning, service detection, SMB enum, web discovery |
| Output | Recon logs, screenshots, 2 reports |

🐚 Week 2 – Enumeration + Shells
| Tools | hydra, ftp, smbclient, curl, nc, nmap --script vuln |
| Machines | Blue, Legacy, Optimum |
| Skills | Brute force, exploiting vulnerable services, uploading shells |
| Output | Shell access on 3 targets, 3 reports, improved enumeration workflow |

🐧 Week 3 – Linux Privilege Escalation
| Tools | linpeas.sh, pspy64, manual file enumeration, sudo -l, SUID/cron/PATH techniques |
| Machines | Beep, Nibbles, Postman |
| Skills | Discovering and exploiting Linux misconfigs for privesc |
| Output | Root access via custom methods, cheatsheet updates, 3 reports |

🪟 Week 4 – Windows Privilege Escalation
| Tools | winpeas.bat, whoami, accesschk.exe, findstr, Windows services abuse |
| Machines | Bastion, Netmon, Arctic |
| Skills | Windows tokens, unquoted paths, service misconfigs, registry keys |
| Output | 3 root flags, screenshots of every PrivEsc vector tested |

💥 Week 5 – Buffer Overflows
| Tools | gdb, pwndbg, pattern_create.rb, pattern_offset.rb, msfvenom, nasm, python |
| Machines | Vulnserver, Brainpan, custom THM BOF lab |
| Skills | Controlling EIP, creating shellcode, building exploits manually |
| Output | 2+ full exploits written manually, report walkthroughs, shell access via BOF |

🌐 Week 6 – Web Vulns I (LFI, Upload, Auth Bypass)
| Tools | burpsuite, ffuf, curl, gobuster, manual payloads |
| Machines | Shocker, Nineveh, Traverxec |
| Skills | Local File Inclusion, file upload bypasses, basic auth bypass |
| Output | Payload collections, reports, screenshots, proof of exploitation |

🧪 Week 7 – Web Vulns II (SQLi, XSS, Broken Auth)
| Tools | sqlmap, Burp, manual injection, browser dev tools |
| Machines | Writeup, Valentine, Curling |
| Skills | SQL injection (manual + tool), reflected/stored XSS, broken logic |
| Output | Proof-of-concept payloads, session token theft, report writeups |

🏰 Week 8 – Active Directory Part 1 (Foothold)
| Tools | rpcclient, smbclient, ldapsearch, crackmapexec, bloodhound, neo4j |
| Machines | Forest, Blackfield |
| Skills | Enumeration of users/groups/domains, user shell via SMB or LDAP |
| Output | Access to domain user, graph of AD structure, BloodHound screenshots |

🔐 Week 9 – AD Part 2 (Kerberoasting, Pivoting, Post)
| Tools | GetUserSPNs.py, chisel, SSH tunneling, impacket, evil-winrm |
| Machines | Reel2, Sizzle |
| Skills | Service ticket abuse, lateral movement, persistence creation |
| Output | SYSTEM access, .kirbi tickets, pivot map, internal recon logs |

🧠 Week 10 – Full Mock OSCP Exam
| Setup | Choose 3 retired OSCP-style boxes from HTB + 1 BOF |
| Time | 24 Hours (simulate exam environment) |
| Output | Full professional pentest report + screenshots, terminal logs, hashes |

📝 Reporting Requirements Per Box
Each box must include:
Nmap scan summary
Enumerated services + versions
Exploitation path (manual if possible)
Privilege escalation method
Post-exploitation loot (hashes, flags, tokens)
Screenshots + exact commands
Lessons learned section

🧠 Reflection Prompts Per Week
What slowed me down the most?
What do I still need to practice?
What would I do differently next time?
What habits are forming from this week?

🔥 End Goal
By the end of 10 weeks, you will be able to:

✅ Manually root Linux and Windows boxes
✅ Perform buffer overflows from scratch
✅ Enumerate and destroy AD networks
✅ Operate under exam pressure
✅ Write full OSCP-style pentest reports
✅ Stand OSCP-ready and ego-driven
