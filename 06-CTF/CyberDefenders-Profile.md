# CyberDefenders — Lab Portfolio

**Profile:** https://cyberdefenders.org/p/artur.demenskiy03/
**Platform:** CyberDefenders (Blue Team CTF)
**Focus:** SOC Analysis, Threat Intelligence, Network and Endpoint Forensics

---

## Completed Labs — 9 Total

| Lab | Category | Difficulty | Tools | Achievement |
|---|---|---|---|---|
| [Red Stealer](#red-stealer) | Threat Intel | Easy | VirusTotal, ANY.RUN, MalwareBazaar | [Link](https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/red-stealer/) |
| [Yellow RAT](#yellow-rat) | Threat Intel | Easy | VirusTotal, Red Canary | [Link](https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/yellow-rat/) |
| [Oski](#oski) | Threat Intel | Easy | VirusTotal, ANY.RUN | [Link](https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/oski/) |
| [Lespion](#lespion) | Threat Intel | Easy | Sherlock, Google, GitHub | [Link](https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/lespion/) |
| [PsExec Hunt](#psexec-hunt) | Network Forensics | Easy | Wireshark | [Link](https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/psexec-hunt/) |
| [PoisonedCredentials](#poisonedcredentials) | Network Forensics | Easy | Wireshark | [Link](https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/poisonedcredentials/) |
| [WebStrike](#webstrike) | Network Forensics | Easy | Wireshark | [Link](https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/webstrike/) |
| [The Crime](#the-crime) | Endpoint Forensics | Easy | ALEAPP, SQLite Browser | [Link](https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/the-crime/) |
| [Amadey - APT-C-36](#amadey-apt-c-36) | Endpoint Forensics | Medium | Volatility 3 | [Link](https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/amadey-apt-c-36/) |

---

## Skills Demonstrated

**Threat Intelligence**
- Malware analysis using VirusTotal, ANY.RUN, MalwareBazaar
- IOC extraction (hashes, IPs, domains, registry keys)
- MITRE ATT&CK technique mapping
- C2 infrastructure identification
- Sandbox report analysis (Stealc, RAT families)

**Network Forensics**
- PCAP analysis with Wireshark
- SMB traffic analysis — PsExec lateral movement detection
- LLMNR/NBT-NS poisoning attack identification
- Web server compromise investigation — web shell, reverse shell, data exfiltration

**Endpoint Forensics**
- Windows memory analysis with Volatility 3
- Android device forensics with ALEAPP
- SQLite database analysis
- Process masquerading detection
- Memory dump reconstruction of malware behavior

**OSINT**
- GitHub credential leak investigation
- Online identity correlation with Sherlock
- Geolocation via image analysis

---

## Lab Notes

---

### Red Stealer

**Category:** Threat Intel | **Difficulty:** Easy
**Tools:** VirusTotal, MalwareBazaar, ThreatFox, ANY.RUN, Whois

**What it was:**
Analyzed a malicious executable. The task was to extract all IOCs, identify the C2 server, map the malware's behavior to MITRE ATT&CK tactics, and find how it escalates privileges.

**MITRE ATT&CK tactics covered:**
Execution, Persistence, Privilege Escalation, Defense Evasion, Discovery, Collection, Impact

**Key skills:**
- Submit file to VirusTotal, read the Behavior tab
- Cross-reference with MalwareBazaar for known samples
- Use ThreatFox to find C2 infrastructure linked to the hash
- Use ANY.RUN for dynamic sandbox analysis (watch what it actually does on Windows)
- Whois lookup on C2 domain

---

### Yellow RAT

**Category:** Threat Intel | **Difficulty:** Easy
**Tools:** VirusTotal, Red Canary

**What it was:**
Analyzed malware artifacts from a RAT (Remote Access Trojan) family. Extracted IOCs, identified C2 servers, mapped adversary tactics using threat intelligence platforms.

**Key skills:**
- IOC extraction from VirusTotal (network connections, file drops, registry changes)
- Using Red Canary threat intelligence for RAT family context
- Understanding RAT capabilities: keylogging, screenshot capture, file exfiltration, remote shell

---

### Oski

**Category:** Threat Intel | **Difficulty:** Easy
**Tools:** VirusTotal, ANY.RUN

**What it was:**
Analyzed a sandbox report from ANY.RUN to investigate Stealc malware behavior. Extracted configuration details (C2 address, targeted browsers/credentials). Mapped observed behavior to MITRE ATT&CK.

**MITRE ATT&CK tactics covered:**
Initial Access, Execution, Defense Evasion, Credential Access, Command and Control, Exfiltration

**Key skills:**
- Reading ANY.RUN sandbox reports
- Identifying Stealc/infostealer behavior: targets browser saved passwords, crypto wallets, FTP credentials
- Config extraction: finding hardcoded C2 in strings or memory

---

### Lespion

**Category:** Threat Intel / OSINT | **Difficulty:** Easy
**Tools:** Sherlock, Google Image Search, Google Maps, GitHub

**What it was:**
Investigated an insider threat. A person had exposed credentials on GitHub. Used OSINT tools to correlate their online identity across platforms and identify their physical location from photos.

**Key skills:**
- Searching GitHub for accidentally committed credentials (API keys, passwords in code)
- Sherlock: find all accounts linked to a username across 300+ platforms
- Reverse image search for geolocation
- OSINT methodology: username -> linked accounts -> physical location

**Sherlock command:**
```bash
python3 sherlock username
```

---

### PsExec Hunt

**Category:** Network Forensics | **Difficulty:** Easy
**Tools:** Wireshark

**What it was:**
Analyzed a PCAP file containing SMB traffic. Identified PsExec being used for lateral movement — an attacker using legitimate Windows admin tool to move between machines.

**Key skills:**
- Filtering SMB traffic in Wireshark: `smb2`
- Identifying PsExec artifacts: PSEXESVC service creation over SMB
- Finding which systems were compromised
- Extracting credentials used for authentication
- Identifying administrative shares accessed: `\\target\ADMIN$`, `\\target\IPC$`

**Wireshark filters:**
```
smb2
smb2.cmd == 5        # SMB2 Create (file access)
tcp.port == 445      # SMB port
```

---

### PoisonedCredentials

**Category:** Network Forensics | **Difficulty:** Easy
**Tools:** Wireshark

**What it was:**
Analyzed a PCAP showing an LLMNR/NBT-NS poisoning attack. Identified the rogue machine performing the attack, the accounts that were compromised, and what systems were affected.

**MITRE ATT&CK tactics covered:**
Credential Access, Collection

**What LLMNR poisoning is:**
1. A Windows machine tries to resolve a hostname that DNS cannot find
2. It falls back to LLMNR (multicast request to the whole network)
3. An attacker on the network responds first and pretends to be the target host
4. The victim sends NTLMv2 authentication to the attacker
5. Attacker captures the NTLMv2 hash and cracks it offline

**Key skills:**
- Wireshark filter for LLMNR: `llmnr`
- Identifying the rogue responder (the machine answering all LLMNR queries)
- Extracting NTLMv2 hashes from the capture
- Understanding Responder tool behavior

---

### WebStrike

**Category:** Network Forensics | **Difficulty:** Easy
**Tools:** Wireshark

**What it was:**
Analyzed a PCAP of a compromised web server. Traced the full attack: initial access, web shell upload, reverse shell connection, and data exfiltration.

**MITRE ATT&CK tactics covered:**
Initial Access, Execution, Persistence, Command and Control, Exfiltration

**Attack chain reconstructed:**
```
Attacker scans web server
    -> finds vulnerable upload endpoint
    -> uploads web shell (.php file)
    -> uses web shell to run commands
    -> establishes reverse shell (C2 over TCP)
    -> exfiltrates data
```

**Key skills:**
- Filtering HTTP traffic: `http`
- Finding file uploads: `http.request.method == "POST"` and look for multipart/form-data
- Identifying web shell access patterns (unusual GET/POST to uploaded file)
- Following TCP streams to reconstruct the reverse shell session
- Finding exfiltrated data in outbound connections

---

### The Crime

**Category:** Endpoint Forensics | **Difficulty:** Easy
**Tools:** ALEAPP, DB Browser for SQLite

**What it was:**
Android device forensics. Used ALEAPP to process Android artifacts and reconstruct a victim's financial details, physical movements, and communication patterns.

**Key skills:**
- ALEAPP: Android Logs Events and Protobuf Parser — processes Android backups and extracts artifacts
- SQLite databases on Android: SMS, call logs, WhatsApp, location history all stored in SQLite files
- Reconstructing timeline from device data
- Reading location data from Google Maps history

---

### Amadey - APT-C-36

**Category:** Endpoint Forensics | **Difficulty:** Medium
**Tools:** Volatility 3

**What it was:**
Most complex lab completed. Analyzed a Windows memory dump from a machine infected with the Amadey Trojan (attributed to APT-C-36 threat actor). Reconstructed malware behavior entirely from memory.

**MITRE ATT&CK tactics covered:**
Execution, Persistence, Privilege Escalation, Defense Evasion, Command and Control, Exfiltration

**What was found in memory:**
- Malicious processes masquerading as system processes
- C2 communication details extracted from network artifacts in memory
- Payload delivery mechanism
- Persistence mechanisms (registry run keys, scheduled tasks)

**Key Volatility commands used:**
```bash
python3 vol.py -f memory.dmp windows.pslist
python3 vol.py -f memory.dmp windows.pstree
python3 vol.py -f memory.dmp windows.netscan
python3 vol.py -f memory.dmp windows.cmdline
python3 vol.py -f memory.dmp windows.malfind
python3 vol.py -f memory.dmp windows.dlllist
```

See full Volatility reference: [[../05-Tools/Volatility]]

---

## Next Labs to Complete

- [ ] Tomcat (Medium) — web server forensics
- [ ] Hammered (Medium) — Apache log analysis
- [ ] REvil (Medium) — ransomware analysis
- [ ] Brave (Medium) — malware analysis
