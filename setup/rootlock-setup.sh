#!/bin/bash

echo "[+] Updating system..."
sudo apt update && sudo apt upgrade -y

echo "[+] Installing core pentesting tools..."
sudo apt install -y nmap netcat-traditional curl wget socat tmux proxychains \
  gobuster ffuf sqlmap nikto wfuzz whatweb whois dnsutils smbclient \
  python3-pip seclists hashcat john rlwrap git unzip gdb gcc make \
  bloodhound neo4j openjdk-11-jre enum4linux-ng crackmapexec \
  libssl-dev libffi-dev python3-dev build-essential

echo "[+] Installing linPEAS and pspy..."
mkdir -p ~/tools && cd ~/tools
wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
wget https://github.com/DominicBreuker/pspy/releases/latest/download/pspy64
chmod +x linpeas.sh pspy64

echo "[+] Installing Metasploit Framework..."
sudo snap install metasploit-framework

echo "[+] Installing Burp Suite Community..."
sudo snap install burpsuite

echo "[+] Installing Go..."
sudo apt install -y golang-go

echo "[+] Installing Go-based tools..."
go install github.com/tomnomnom/assetfinder@latest
go install github.com/ffuf/ffuf@latest
go install github.com/sensepost/gowitness@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/OWASP/Amass/v3/...@latest

echo "[+] Adding Go bin to PATH if not already present..."
if ! grep -q 'export PATH=$PATH:$HOME/go/bin' ~/.bashrc; then
  echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
fi
source ~/.bashrc

echo "[✓] Setup complete. Reboot recommended for all changes to take effect."
