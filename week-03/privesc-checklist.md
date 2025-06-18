| Step            | Command                         | What You're Looking For                  |
| --------------- | ------------------------------- | ---------------------------------------- |
| 1. User         | `whoami && id`                  | Your privileges and groups               |
| 2. System       | `uname -a`, `cat /etc/*release` | Kernel, OS version                       |
| 3. Sudo         | `sudo -l`                       | Misconfigurations, no-password access    |
| 4. SUID         | `find / -perm -u=s -type f`     | Dangerous SUID binaries                  |
| 5. Cron         | `ps aux`, `crontab -l`          | Writable scripts, root cron jobs         |
| 6. Env          | `env`, `echo $PATH`             | Writable dirs in `$PATH`, hijack chances |
| 7. Capabilities | `getcap -r /`                   | Special powers assigned to binaries      |
