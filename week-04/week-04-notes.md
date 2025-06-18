# Windows Enumeration

## Core Enumeration

`whoami` - shows the current running user, can help us see if we are system, admin, or a low privilege user

`whoami /priv` - lists security privileges, some privesc exploits require specific privileges

`whoami /groups` - shows what groups were in, finding that we are in groups like Administrator, remote desktop users, or backup can give us paths to escalation

`hostname` - shows the computers hostname, helpful for naming, logging, pivoting

`systeminfo` - detailed system info, finding common CVEs, determining OS version, running windows exploit suggester 

`echo %USERNAME%`, `echo %USERDOMAIN%`, `echo %COMPUTERNAME%`: display environment variables, see if we are on domain and identifying what context were operating in

## Account & Privilege Discovery

`net users` - lists all local user accounts on the system, identify targets like admin and backup users for lateral movement or finding credentials

`net user [current-user]` - details about a user: groups, last logon, password settings, details such as password doesn't expire or misconfigs 

`net localgroup administrators` - shows which users belong to the admin group, check if your user is already admin or if there's a weak user we can pivot through 

`net localgroup` - lists all local groups on the machine, look for custom or privileged groups like "backup operators" or "remote management users"

## Services & Processes

`tasklist /v` - list all running processes with extra info, find high privileged processes, spot custom or strange services we can exploit 

`sc query` - list all services and their statuses, find services to investigate for misconfigs or privilege escalation 

`sc query [service-name]` - shows configs of a specific service like its binary path and permissions, look for unquoted service paths, see if its modifiable 

`wmic service list brief` - shows all services in a compact format, quick scanning for service names + file paths, quick for finding bad paths

## Patch Level & Hotfixes

`wmic qfe get Caption,Description,HotFixID,InstalledOn` - list all patches and hotfixes, tools like windows exploit suggester can help us find missing patches, helps determine if certain known CVE exploits are possible

## Environment & Startup 

`set` - display all environment variables, reveals useful paths or misconfigs, can leak user info, program data, and temp directories

`echo $PATH` - shows system PATH variable, see if it contains writable directories for possible hijacking 

`reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"` - lists programs set to run on startup, if these registry keys are writable we can inject a payload

---

# Unquoted Service Paths & Weak Permissions

```php
wmic service get name,pathname,startmode
```

Windows Management Instrumentation Command-line, utility to list information about installed services 