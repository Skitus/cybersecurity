# CyberDefenders

https://cyberdefenders.org/p/artur.demenskiy03/

---

## Completed Labs

### Red Stealer — Threat Intel

https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/red-stealer/

Tools: VirusTotal, ANY.RUN, MalwareBazaar, ThreatFox

- Uploaded sample to VirusTotal → checked detection rate, Behavior tab
- Found C2 domain via ThreatFox (linked to hash)
- Ran sample in ANY.RUN sandbox → watched what it actually does on Windows live
- Mapped behavior to MITRE ATT&CK: T1059 Execution, T1547 Persistence, T1055 Privilege Escalation

---

### Yellow RAT — Threat Intel

https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/yellow-rat/

Tools: VirusTotal, Red Canary

- Pulled IOCs from VirusTotal: network connections, dropped files, registry keys
- Used Red Canary to get context on the RAT family
- Identified C2 IPs and beacon interval

---

### Oski — Threat Intel

https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/oski/

Tools: VirusTotal, ANY.RUN

- Analyzed ANY.RUN sandbox report for Stealc/Oski infostealer
- Found malware targets: browser saved passwords, crypto wallets, FTP clients
- Extracted hardcoded C2 from strings
- MITRE: T1555 Credentials from Password Stores, T1041 Exfiltration over C2

---

### Lespion — OSINT / Threat Intel

https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/lespion/

Tools: Sherlock, GitHub, Google Image Search, Google Maps

- Found exposed credentials in GitHub commit history
- Ran Sherlock to find all accounts linked to the username:
```bash
python3 sherlock <username>
```
- Reverse image searched photos → identified location via Google Maps landmarks

---

### PsExec Hunt — Network Forensics

https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/psexec-hunt/

Tools: Wireshark

- Opened PCAP, filtered SMB traffic:
```
smb2
tcp.port == 445
```
- Found PSEXESVC service being created over SMB → PsExec lateral movement
- Identified source machine, target machine, credentials used, admin shares accessed: `\\target\ADMIN$`

---

### PoisonedCredentials — Network Forensics

https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/poisonedcredentials/

Tools: Wireshark

- Filtered LLMNR traffic → found rogue Responder machine answering all requests
- Extracted NTLMv2 hashes from NTLMSSP auth packets
- Identified compromised accounts and source machines
- Same technique as [[../06-CTF/pcap-llmnr|LLMNR practice lab]]

---

### WebStrike — Network Forensics

https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/webstrike/

Tools: Wireshark

- Filtered HTTP traffic, found file upload (multipart POST)
- Identified web shell uploaded to server
- Followed TCP stream → saw attacker using web shell to run commands
- Found reverse shell connection (outbound TCP to attacker IP)
- Found data exfiltration in outbound traffic

---

### The Crime — Endpoint Forensics

https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/the-crime/

Tools: ALEAPP, DB Browser for SQLite

- Processed Android backup with ALEAPP → extracted artifacts
- Opened SQLite databases: SMS, call logs, location history
- Reconstructed victim timeline: messages, GPS coordinates, financial transactions

---

### Amadey - APT-C-36 — Endpoint Forensics

https://cyberdefenders.org/blueteam-ctf-challenges/achievements/artur.demenskiy03/amadey-apt-c-36/

Tools: Volatility 3

- Analyzed Windows memory dump from Amadey-infected machine
- Commands run:
```bash
python3 vol.py -f memory.dmp windows.pslist
python3 vol.py -f memory.dmp windows.pstree
python3 vol.py -f memory.dmp windows.netscan
python3 vol.py -f memory.dmp windows.cmdline
python3 vol.py -f memory.dmp windows.malfind
```
- Found: masqueraded process (lssass.exe in C:\Temp\), C2 IP in netscan output, persistence via Run key in cmdline output
- Full notes: [[../05-Tools/Volatility]]
