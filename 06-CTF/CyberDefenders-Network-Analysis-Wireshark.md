# Network Forensics — Wireshark and Process Analysis

**Date studied:** 2025-05
**Platform:** CyberDefenders + custom Claude labs
**Lab:** Amadey malware analysis
**Category:** Network Forensics / Memory Forensics / Blue Team
**Status:** In Progress

---

## What Was Done

Analyzed a Windows system infected with the **Amadey** malware family.
Compared process lists from a clean machine vs an infected machine to identify malicious indicators.
Practiced network traffic analysis across 8+ different PCAP scenarios.

---

## Amadey Malware — Process Analysis

Comparison between a clean machine and an infected machine:

| Process | Clean Machine | Infected Machine |
|---|---|---|
| msedge.exe | normal | - |
| explorer.exe | normal | - |
| Signal.exe | normal | - |
| OneDrive.exe | normal | - |
| lsass.exe | - | **lssass.exe** — typosquatting lsass (double s) |
| path | normal system paths | **C:\Temp\925e7e99c5\lssass.exe** — runs from Temp |
| rundll32 | - | **loads clip64.dll** — suspicious DLL |
| cmd.exe | - | **spawned at 21:50** — unexpected shell |

### What Each Indicator Means

**lssass.exe masquerading as lsass.exe**
- `lsass.exe` is a legitimate Windows process (Local Security Authority)
- Malware adds an extra `s` to the name to fool analysts at a glance
- Running from `C:\Temp\` instead of `C:\Windows\System32\` — immediate red flag
- Any process in `C:\Temp\` is suspicious

**rundll32 loading clip64.dll**
- `rundll32.exe` is used to run DLL files as executables
- Attackers abuse it to execute malicious DLLs without creating a new `.exe`
- `clip64.dll` is not a standard Windows DLL

**cmd.exe spawned at 21:50**
- Unexpected command shell at a specific time suggests scheduled task or malware trigger
- Parent process matters: cmd.exe spawned by malware is a sign of lateral movement or persistence

---

## Live Network Analysis

Command used to see active connections on Windows:

```powershell
netstat -ano | Select-String "ESTABLISHED"
```

What it shows:
- All established TCP connections
- Local address and port
- Remote IP address and port
- PID of the process owning the connection

Cross-reference the PID with Task Manager or `Get-Process -Id <PID>` to find which process is connecting where.

This is the live equivalent of `windows.netscan` in Volatility (which does the same from a memory dump).

---

## Volatility — Memory Forensics Commands

Volatility is used to analyze memory dumps (`.dmp`, `.mem`, `.raw` files).

```bash
# List all running processes
volatility -f memory.dmp windows.pslist

# Show process tree (parent-child relationships)
volatility -f memory.dmp windows.pstree

# Find network connections (equivalent of netstat)
volatility -f memory.dmp windows.netscan

# Show command line used to launch each process
volatility -f memory.dmp windows.cmdline

# List DLLs loaded by each process
volatility -f memory.dmp windows.dlllist

# Find injected code in process memory
volatility -f memory.dmp windows.malfind

# Dump a specific process to disk
volatility -f memory.dmp windows.dumpfiles --pid <PID>

# Check for hidden processes (rootkits)
volatility -f memory.dmp windows.psxview
```

### Red Flags in Volatility Output

- Process running from `C:\Temp\`, `C:\Users\AppData\`, or random paths
- Typosquatted process names (lssass, scvhost, svhost)
- `cmd.exe` or `powershell.exe` as child of a browser or Office process
- Network connections from unexpected processes (e.g., Word.exe connecting to an IP)
- `rundll32.exe` with suspicious DLL arguments

---

## PCAP Labs Practiced

Files are in: `./pcap-files/`

### 1. Malware Traffic
- Look for: periodic beacons (C2 heartbeat at fixed intervals), DNS queries to random domains, POST requests with encoded data
- Filter: `http.request.method == "POST"` / `dns`

### 2. VoIP Analysis
- Look for: SIP REGISTER/INVITE packets, RTP audio streams
- Filter: `sip` / `rtp`
- Can extract audio from RTP streams: Telephony > RTP > Stream Analysis

### 3. LLMNR Poisoning
- LLMNR = Link-Local Multicast Name Resolution (Windows name resolution fallback)
- Attacker responds to LLMNR queries and captures NTLMv2 hashes
- Tool used by attackers: Responder
- Filter: `llmnr` / `nbns`

### 4. DNS Tunneling
- Data exfiltration or C2 hidden inside DNS queries
- Queries are abnormally long (> 50 chars in subdomain)
- High volume of TXT record requests
- Filter: `dns` then look at query lengths

### 5. Web Attack Traffic
- Look for: SQLi payloads in URLs (`UNION SELECT`, `' OR 1=1`), directory traversal (`../../../`), XSS (`<script>`)
- Filter: `http` then inspect URIs

### 6. WiFi Analysis
- 802.11 frames, deauthentication attacks (deauth flood = DoS)
- WPA2 handshake capture (4-way handshake = crackable offline)
- Filter: `wlan`

### 7. Attack CTF
- Port scan signatures: many SYN packets to sequential ports from one IP
- Exploit attempts: unusual payloads in TCP streams
- Filter: `tcp.flags.syn == 1 && tcp.flags.ack == 0`

---

## Wireshark Core Filters Reference

```
# By IP
ip.addr == 10.0.0.1
ip.src == 10.0.0.1
ip.dst == 10.0.0.1

# By protocol
http
dns
ftp
smtp
smb

# By port
tcp.port == 4444
udp.port == 53

# Find SYN scans
tcp.flags.syn == 1 && tcp.flags.ack == 0

# Find POST requests
http.request.method == "POST"

# Exclude noise
not arp and not icmp

# Follow a stream: right-click > Follow > TCP Stream
```

---

## Tools Used

| Tool | Purpose |
|---|---|
| Wireshark | PCAP analysis, traffic inspection |
| Volatility 3 | Memory dump analysis |
| netstat -ano | Live network connection enumeration |
| CyberDefenders | Lab platform |

---

## References

- [CyberDefenders Amadey Lab](https://cyberdefenders.org)
- [Volatility 3 Docs](https://volatility3.readthedocs.io)
- [Wireshark Display Filters](https://www.wireshark.org/docs/dfref/)
- [Amadey malware analysis — ANY.RUN](https://any.run/malware-trends/amadey)
