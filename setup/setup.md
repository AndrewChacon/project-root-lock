# 🛠️ Bluelock Pentesting Setup Script

This setup script prepares a **Ubuntu Linux** machine for offensive security work, including OSCP-style labs, Hack The Box, and Project Root Lock.

---

## 📦 Tools Installed

-   🔍 **Recon & Enum**: `nmap`, `ffuf`, `gobuster`, `enum4linux-ng`, `whatweb`, `whois`, `dnsutils`
-   🐚 **Shells & Access**: `netcat-traditional`, `proxychains`, `smbclient`, `curl`, `wget`
-   💣 **Exploitation**: `sqlmap`, `nikto`, `wfuzz`, `hydra`, `msfconsole`, `msfvenom`
-   🧪 **Post Exploitation**: `linpeas`, `pspy`, `crackmapexec`, `bloodhound`, `neo4j`
-   📚 **Dev & Buffers**: `gdb`, `pwndbg`, `gcc`, `make`, `python3-pip`, `build-essential`
-   🧰 **Wordlists & Extras**: `seclists`, `rockyou.txt`, `john`, `hashcat`, `rlwrap`, `tmux`
-   🧠 **Go Tools**: `assetfinder`, `ffuf`, `gowitness`, `httpx`, `subfinder`, `amass`

---

## 🚀 Installation

```bash
chmod +x bluelock-setup.sh
./bluelock-setup.sh
```

---

## 📁 Downloads & Paths

-   Go-based tools installed to: `~/go/bin`
-   Custom tools like `linpeas.sh` and `pspy64` saved in: `~/tools`

---

## 🔁 Post-Install Steps

-   Restart your shell or run `source ~/.bashrc` to update `$PATH`
-   Optional: Reboot your system to finalize environment changes

---
