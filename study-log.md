
# Week 1
## Mon 26 May 2025
Some of the topics that became fuzzy for me where timing options and navigating firewalls, I think I just need more chances to apply those things to really get it. As for advanced scanning, it felt overwhelming seeing just how many flags and options you have. Its a lot to take in but ill focus on remembering the most common ones found over the more situational ones. 
I still need more time for the methodology to sick in, that's just a matter of experience over time from practicing more. 
If I can finish this week quicker id like to send more time understanding how to navigate firewalls better. Id also like a chance to learn more about networks and how they work at a lower level. 

## Tue 27 May 2025
I think one useful thing I did today that ill start building up a habit of is, while I'm learning, finish learning the tool or concept but jot down things I didn't fully understand. After I finished I researched them, I think if I did this during the process it would have lead to more confusion. Finish the task then go back for edge cases. 
I had questions/uncertainties about things like how whatweb fingerprinting worked, how recursion in `fuff` worked, how subdomain enumeration worked in `gobuster`, and what the difference between directory brute forcing vs fuzzing was. After I finished the days agenda I went back and added notes that answered those questions I had. 
Towards the end of the week I should write a methodology sheet for steps to attacking a victim like running `nmap`, then running `fuff` and `gobuster` scans, etc. 
I scanned on the HTB machine called `bashed` I got some pretty good progress investigating it, I don't think I was too far from rooting it even though that wasn't a part of today's plan.

## Wed 28 May 2025
Today was challenging for a completely different reason than the content of the program. 
To connect to a HTB machine requires us to connect to their VPN, this creates a secret tunnel that our network can connect to `tun0`
For someone the VPN might not have closed properly when I shut it down so it had multiple VPN instances and secret tunnels, I'm assuming they weren't shutting down properly.
Anyway I did research for the commands to kill those connections, I should check this soon as I start work to avoid this issue.

```php
sudo killall openvpn
ip a | grep tun
```

The actual research on SMB enumeration was very helpful and insightful, I think I have a decent grasp on it what I require is more practice with it.
There's also a connection on HTB called starting point that has starter boxes to hack, If I can start finishing a lot sooner I'd like to do this. 
Extra practice would do be a lot of good.  

## Thur 29 May 2025
Today was pretty light, after I submit all of this I'm gonna work on the HTB starting point.
Doing this recon stuff was pretty cool, I found 2 vulnerabilities on the Lame machine. 
The first one is for was `vsFTPd 2.3.4` and the other was `OpenSSH_4.7.p1`. 
I think if I get bored ill just jump the gun and try to root the Lame and Jerry machine. 
The recon stuff is cool, I've used it before but I want to understand how it works under the hood, however It feels a lot like review. It's was lacking the intensity I wanted but I hope that's what I get in the following weeks to come.

## Fri 30 May 2025
Today I had a huge hold back on the Jerry machine, the guide I followed had a requirement of running python 3.7 and I just couldn't get it to work right. The same for trying to use the metasploit option It just wasn't working too well for me. I know this should work but its just not I think its something with the VPN again, I have Sunday to recover. 

## Sat 31 May 2025
Same issue today but with the Lame machine, its again another issue with the `msfvenom` payload, but also the manual route was giving me errors.
After some work I realized I failed to use my `inet` IP from the secret tunnel from the VPN. 
Now thinking about it I think this is also the same issue with the Jerry machine.
I feel so miserable and frustrated about this stupid issue, Sunday has become my holy grail I know what needs to be done now tomorrow will be a piece of cake.

## Sun 1 June 2025
Wow its already June, actually fuck my life lol. I was totally right about the secret tunnel, my reverse shells started working again and I was able to gain remote command execution on both machines. I had a pretty good start on those reports so today was like clean up duty. I'll ask Justin tomorrow for any advice/resources on writing reports better, need to know what the industry standards for them look like. I don't even want to look at what week 2 is gonna be about. I don't think I have work tomorrow so lets get week 2 day 1 over with quick and work on tier 1 of starting point HTB machines. 
Week 1 was for sure was interesting, I found a lot of value going deeper into the fundamentals, I believe that's why I was able to debug all my errors. 

# Week 2

## Mon 2 June 2025
Today was good, I didn't mean to root the legacy machine today but I did, I wrote the report too. I did do it with metasploit using two different attack points. I tried to do manual exploit but I'm running to into issues since its an old python script. I'll try again later but if anything I have till Sunday to make that up. I stayed up all night I just couldn't sleep so I did my cyber learning first thing in the morning. Maybe ill do tier 1 of starting point machines tonight for extra practice after I've gotten a break from the grind. 

## Tue 3 June 2025
Now were getting into some interesting stuff to play around with. I was able to connect on FTP and get in with an anonymous login.
I downloaded files, found 5 files that might contain useful info for us later.
I set up a reverse shell script and a web server to host it but it's looking like we don't have download permissions on this account so we can't upload our malicious script quite just yet. 

