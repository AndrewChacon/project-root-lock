# 🧠 Nmap Recon Cheatsheet

_Built for offensive recon — HTB, labs, OSCP-style._

---

## 🔍 BASIC USAGE

```bash
nmap 10.129.55.151                  # Scan top 1000 ports (default)
nmap -F 10.129.55.151               # Fast scan (top 100 ports)
nmap -v -Pn 10.129.55.151           # Verbose, no ping check
nmap -p- 10.129.55.151              # Scan all 65535 ports
nmap -p 22,80,443 10.129.55.151     # Scan specific ports
nmap -p 1-1000 10.129.55.151        # Scan port range

```

---

## 🌐 NETWORK SCANNING

```bash
nmap 10.129.55.1-10                 # Scan range
nmap 10.129.55.0/24                 # Scan entire subnet
nmap -iL targets.txt                # Scan list of targets
nmap --exclude 10.129.55.5          # Exclude target(s)
nmap --excludefile exclude.txt     # Exclude from file
```

---

## 🧠 OS & SERVICE DETECTION

```bash
nmap -sC -sV -O -Pn TARGET          # Full detection scan
nmap -sV --version-trace TARGET     # Verbose service version
nmap -O --osscan-guess TARGET       # Aggressive OS fingerprinting
```

---

## ⚙️ TIMING, SPEED & PARALLELISM

```bash
nmap -T4 TARGET                     # Aggressive timing
nmap --min-rate 200 TARGET          # Send at least X packets/sec
nmap --max-retries 3 TARGET         # Retry limit
nmap --min-parallelism 50 TARGET    # Scan 50 ports in parallel (min)
nmap --host-timeout 30s TARGET      # Timeout after 30s per host
```

---

## 🔎 PING & DISCOVERY MODES

```bash
nmap -sP 10.129.55.0/24             # Ping sweep
nmap -Pn TARGET                     # Skip host discovery (assume up)
nmap -PS22,80 TARGET                # TCP SYN ping
nmap -PA80,443 TARGET               # TCP ACK ping
nmap -PU53,161 TARGET               # UDP ping
nmap -PE TARGET                     # ICMP Echo ping
nmap -PR TARGET                     # ARP ping (local net)
```

---

## 🔐 STEALTH & BYPASS

```bash
nmap -sS TARGET                     # Stealth SYN scan
nmap -sT TARGET                     # TCP connect scan
nmap -sN TARGET                     # NULL scan
nmap -sF TARGET                     # FIN scan
nmap -sX TARGET                     # XMAS scan
nmap -D RND:10 TARGET               # Decoy scan
nmap --spoof-mac 0 TARGET           # MAC spoofing (random)
nmap --badsum TARGET                # Bad checksum evasion
```

---

## 🔧 OUTPUT & FORMAT

```bash
nmap -oN output.txt TARGET          # Normal output
nmap -oX output.xml TARGET          # XML output
nmap -oG grepable.txt TARGET        # Greppable output
nmap -oA all-formats TARGET         # All formats
```

---

## 🌐 WEB & ENUM EXTRAS

```bash
nmap -p 80,443 --script http-enum TARGET
nmap -p 139,445 --script smb-os-discovery TARGET
nmap --script vuln TARGET          # Run vulnerability scripts
```

---

## 📦 CUSTOM TRICKS

```bash
nmap --reason TARGET                # Show why port is in its state
nmap --open TARGET                  # Show only open ports
nmap --packet-trace TARGET          # Debug packet exchange
nmap --traceroute TARGET            # Show path to host
nmap -R TARGET                      # Force reverse DNS
nmap -n TARGET                      # Disable DNS resolution
```

---

### 💡 Pro Tip: Full Recon Combo (HTB/OSCP Box)

```bash
nmap -sS -Pn -T4 -p- -oA nmap/full TARGET
nmap -sC -sV -p <open-ports> -oA nmap/detail TARGET
```

