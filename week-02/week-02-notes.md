Today's focus will be identifying SMB vulnerabilities, enumerating shares users and configs, testing access, looking for valuable resources, and uploading a reverse shell if we find that there is write access.

Our goal is to gain a low privilege foothold by exploiting misconfigured or vulnerable SMB services manually, no automation tools like metasploit

SMB is commonly misconfigured, frequently exposes info like passwords, config files, up-loadable shares. Often allows guest or null session unauthenticated access, can read to a file upload reverse shell.

---

# FTP / SSH Brute Force + File Transfer

FTP (File Transfer Protocol) is used to transfer files between client and server
Scans on Port 21
Can be anonymous or credential based
Can be active or passive, passive used for firewalls

We can run commands like:
- `get filename` - download file 
- `put filename` - upload file
- `ls` - list all files
- `cd` - change directory
- `bye` or `exit` - quit

Were trying to find anonymous logins, looking for sensitive files, uploading malicious files, and escalating them to gain shell access. 

Hydra is a login cracker tool, used for brute forcing usernames and passwords against a service like `FTP`, `SSH`, `HTTP`, and `RDP`.
We provide it the target IP, wordlists for usernames and passwords, and a service. 
Hydra will make several login attempts in rapid succession. 