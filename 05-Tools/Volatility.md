# Volatility — Memory Forensics

**Category:** Digital Forensics / Memory Analysis
**Version:** Volatility 3 (python3 based)

---

## What It Is

Volatility is an open-source memory forensics framework.
It analyzes RAM dumps (memory images) from Windows, Linux, and macOS.
Used by incident responders and malware analysts to find what was running in memory — including malware that hides itself from the filesystem.

---

## Installation

```bash
git clone https://github.com/volatilityfoundation/volatility3
cd volatility3
pip3 install -r requirements.txt
python3 vol.py --help
```

---

## Getting a Memory Dump

**Windows (for practice):**
```powershell
# Using winpmem (free)
winpmem.exe memory.raw

# Using Task Manager: right-click process > Create dump file
# (process dump, not full RAM)
```

**In a lab/CTF:** the `.dmp` or `.mem` file is provided.

---

## Core Commands

### Process Analysis

```bash
# List processes (like Task Manager)
python3 vol.py -f memory.dmp windows.pslist

# Process tree — shows parent/child relationships
python3 vol.py -f memory.dmp windows.pstree

# Find hidden/unlinked processes (rootkit detection)
python3 vol.py -f memory.dmp windows.psxview

# Show command line used to launch each process
python3 vol.py -f memory.dmp windows.cmdline
```

### Network Analysis

```bash
# Show all network connections (established, listening, closed)
python3 vol.py -f memory.dmp windows.netscan

# Equivalent of running: netstat -ano on the live system
```

### DLL and Code Analysis

```bash
# List DLLs loaded by each process
python3 vol.py -f memory.dmp windows.dlllist

# Find injected code / shellcode in process memory
python3 vol.py -f memory.dmp windows.malfind

# Dump a process to a file for further analysis
python3 vol.py -f memory.dmp windows.dumpfiles --pid 1234
```

### Registry and Persistence

```bash
# List registry hives in memory
python3 vol.py -f memory.dmp windows.registry.hivelist

# Print registry key values
python3 vol.py -f memory.dmp windows.registry.printkey --key "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
```

### File System

```bash
# List files cached in memory
python3 vol.py -f memory.dmp windows.filescan

# Dump a specific file from memory
python3 vol.py -f memory.dmp windows.dumpfiles --virtaddr 0xADDRESS
```

---

## Malware Hunting Workflow

```
1. windows.pslist        - get all processes
2. windows.pstree        - look for suspicious parent-child (Word.exe -> cmd.exe)
3. windows.cmdline       - check what arguments processes were launched with
4. windows.netscan       - find unexpected network connections
5. windows.malfind       - find injected shellcode
6. windows.dlllist       - check for suspicious DLLs loaded into legitimate processes
7. windows.dumpfiles     - extract suspicious files from memory
```

---

## Red Flags

| Finding | What It Means |
|---|---|
| Process running from `C:\Temp\` | Malware staging area |
| Typosquatted name (`lssass`, `scvhost`) | Process masquerading |
| `cmd.exe` child of browser/Office | Code execution via exploit |
| `powershell.exe -enc <base64>` | Encoded PowerShell — hiding commands |
| Network connection from `svchost` to external IP | Possible C2 beacon |
| `rundll32.exe` with unknown DLL | DLL execution abuse |
| Injected memory regions (malfind) | Shellcode or reflective DLL injection |

---

## Live Equivalent Commands (Windows)

When you have access to the live system instead of a dump:

```powershell
# See processes
Get-Process
tasklist /v

# See network connections with PIDs
netstat -ano | Select-String "ESTABLISHED"

# Find process by PID
Get-Process -Id 1234

# See DLLs loaded by a process
Get-Process -Id 1234 | Select-Object -ExpandProperty Modules
```

---

## References

- [Volatility 3 GitHub](https://github.com/volatilityfoundation/volatility3)
- [Volatility 3 Docs](https://volatility3.readthedocs.io)
- [Memory Forensics Cheat Sheet](https://downloads.volatilityfoundation.org/releases/2.4/CheatSheet_v2.4.pdf)
