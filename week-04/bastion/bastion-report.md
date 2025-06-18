ssh l4mpje/bureaulampje

# Running Commands

```php
whoami                                                                           
bastion\l4mpje
```

```php
whoami /priv                                                                                     
PRIVILEGES INFORMATION                                                           ----------------------                                                                                                          

Privilege Name                Description                    State                                        
============================= ============================== =======                                                            
SeChangeNotifyPrivilege       Bypass traverse checking       Enabled                                                            
SeIncreaseWorkingSetPrivilege Increase a process working set Enabled
```

```php
whoami /priv                                                                                     

PRIVILEGES INFORMATION                                                                                                          
----------------------                                                                                                          

Privilege Name                Description                    State                                                              
============================= ============================== =======                                                            
SeChangeNotifyPrivilege       Bypass traverse checking       Enabled                                                            
SeIncreaseWorkingSetPrivilege Increase a process working set Enabled                                                            

l4mpje@BASTION C:\Users\L4mpje>whoami /groups                                                                                   

GROUP INFORMATION                                                                                                               
-----------------                                                                                                               

Group Name                             Type             SID          Attributes                                                 
====================================== ================ ============ ==================================================         
Everyone                               Well-known group S-1-1-0      Mandatory group, Enabled by default, Enabled group         
BUILTIN\Users                          Alias            S-1-5-32-545 Mandatory group, Enabled by default, Enabled group         
NT AUTHORITY\NETWORK                   Well-known group S-1-5-2      Mandatory group, Enabled by default, Enabled group         
NT AUTHORITY\Authenticated Users       Well-known group S-1-5-11     Mandatory group, Enabled by default, Enabled group         
NT AUTHORITY\This Organization         Well-known group S-1-5-15     Mandatory group, Enabled by default, Enabled group         
NT AUTHORITY\Local account             Well-known group S-1-5-113    Mandatory group, Enabled by default, Enabled group         
NT AUTHORITY\NTLM Authentication       Well-known group S-1-5-64-10  Mandatory group, Enabled by default, Enabled group         
Mandatory Label\Medium Mandatory Level Label            S-1-16-8192
```

```php
hostname                                                                         Bastion
```

```php
echo %USERNAME% %COMPUTERNAME% %USERDOMAIN%                                                      
l4mpje BASTION WORKGROUP
```

```php
net users                                                                                        

User accounts for \\BASTION                                                                                                     

-------------------------------------------------------------------------------                                                 
Administrator            DefaultAccount           Guest                                                                         
L4mpje                                                                                                                          
The command completed successfully. 
```

```php
net users                                                                                        

User accounts for \\BASTION                                                                                                     

-------------------------------------------------------------------------------                                                 
Administrator            DefaultAccount           Guest                                                                         
L4mpje                                                                                                                          
The command completed successfully.                                                                                             


l4mpje@BASTION C:\Users\L4mpje>net user L4mpje                                                                                  
User name                    L4mpje                                                                                             
Full Name                    L4mpje                                                                                             
Comment                                                                                                                         
User's comment                                                                                                                  
Country/region code          000 (System Default)                                                                               
Account active               Yes                                                                                                
Account expires              Never                                                                                              

Password last set            22-2-2019 14:42:58                                                                                 
Password expires             Never                                                                                              
Password changeable          22-2-2019 14:42:58                                                                                 
Password required            Yes                                                                                                
User may change password     No                                                                                                 

Workstations allowed         All                                                                                                
Logon script                                                                                                                    
User profile                                                                                                                    
Home directory                                                                                                                  
Last logon                   18-6-2025 01:42:10                                                                                 

Logon hours allowed          All                                                                                                

Local Group Memberships      *Users                                                                                             
Global Group memberships     *None                                                                                              
The command completed successfully.
```

```php
net localgroup                                                                                   

Aliases for \\BASTION                                                                                                           

-------------------------------------------------------------------------------                                                 
*Access Control Assistance Operators                                                                                            
*Administrators                                                                                                                 
*Backup Operators                                                                                                               
*Certificate Service DCOM Access                                                                                                
*Cryptographic Operators                                                                                                        
*Distributed COM Users                                                                                                          
*Event Log Readers                                                                                                              
*Guests                                                                                                                         
*Hyper-V Administrators                                                                                                         
*IIS_IUSRS                                                                                                                      
*Network Configuration Operators                                                                                                
*Performance Log Users                                                                                                          
*Performance Monitor Users                                                                                                      
*Power Users                                                                                                                    
*Print Operators                                                                                                                
*RDS Endpoint Servers                                                                                                           
*RDS Management Servers                                                                                                         
*RDS Remote Access Servers                                                                                                      
*Remote Desktop Users                                                                                                           
*Remote Management Users                                                                                                        
*Replicator                                                                                                                     
*Storage Replica Administrators                                                                                                 
*System Managed Accounts Group                                                                                                  
*Users                                                                                                                          
The command completed successfully.
```

```php
set

ALLUSERSPROFILE=C:\ProgramData                                                                                                  
APPDATA=C:\Users\L4mpje\AppData\Roaming                                                                                         
CommonProgramFiles=C:\Program Files\Common Files                                                                                
CommonProgramFiles(x86)=C:\Program Files (x86)\Common Files                                                                     
CommonProgramW6432=C:\Program Files\Common Files                                                                                
COMPUTERNAME=BASTION                                                                                                            
ComSpec=C:\Windows\system32\cmd.exe                                                                                             
HOME=C:\Users\L4mpje                                                                                                            
HOMEDRIVE=C:                                                                                                                    
HOMEPATH=\Users\L4mpje                                                                                                          
LOCALAPPDATA=C:\Users\L4mpje\AppData\Local                                                                                      
LOGNAME=l4mpje                                                                                                                  
NUMBER_OF_PROCESSORS=2                                                                                                          
OS=Windows_NT                                                                                                                   
Path=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenSS
H-Win64;C:\Windows\system32\config\systemprofile\AppData\Local\Microsoft\WindowsApps;C:\Users\L4mpje\AppData\Local\Microsoft\Win
dowsApps;                                                                                                                       
PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC                                                                   
PROCESSOR_ARCHITECTURE=AMD64                                                                                                    
PROCESSOR_IDENTIFIER=AMD64 Family 25 Model 1 Stepping 1, AuthenticAMD                                                           
PROCESSOR_LEVEL=25                                                                                                              
PROCESSOR_REVISION=0101                                                                                                         
ProgramData=C:\ProgramData                                                                                                      
ProgramFiles=C:\Program Files                                                                                                   
ProgramFiles(x86)=C:\Program Files (x86)                                                                                        
ProgramW6432=C:\Program Files                                                                                                   
PROMPT=l4mpje@BASTION $P$G                                                                                                      
PSModulePath=C:\Program Files\WindowsPowerShell\Modules;C:\Windows\system32\WindowsPowerShell\v1.0\Modules                      
PUBLIC=C:\Users\Public                                                                                                          
SHELL=c:\windows\system32\cmd.exe                                                                                               
SSH_CLIENT=10.10.14.209 54190 22                                                                                                
SSH_CONNECTION=10.10.14.209 54190 10.129.136.29 22                                                                              
SSH_TTY=windows-pty                                                                                                             
SystemDrive=C:                                                                                                                  
SystemRoot=C:\Windows                                                                                                           
TEMP=C:\Users\L4mpje\AppData\Local\Temp                                                                                         
TERM=xterm-256color                                                                                                             
TMP=C:\Users\L4mpje\AppData\Local\Temp                                                                                          
USER=l4mpje                                                                                                                     
USERDOMAIN=WORKGROUP                                                                                                            
USERNAME=l4mpje                                                                                                                 
USERPROFILE=C:\Users\L4mpje                                                                                                     
windir=C:\Windows
```

```php
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"                                   

HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run                                                                
    VMware VM3DService Process    REG_SZ    "C:\Windows\system32\vm3dservice.exe" -u                                            
    VMware User Process    REG_SZ    "C:\Program Files\VMware\VMware Tools\vmtoolsd.exe" -n vmusr
```