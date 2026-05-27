# Cybersecurity Notes and Lab Portfolio

Personal knowledge base and lab writeups.
Notes from completed CTF labs, real-world case studies, and research.
Written in Obsidian, synced to GitHub.

---

## CyberDefenders — 9 Labs Completed

Profile: https://cyberdefenders.org/p/artur.demenskiy03/

| Lab | Category | Tools |
|---|---|---|
| Red Stealer | Threat Intel | VirusTotal, ANY.RUN, MalwareBazaar |
| Yellow RAT | Threat Intel | VirusTotal, Red Canary |
| Oski | Threat Intel | VirusTotal, ANY.RUN (Stealc analysis) |
| Lespion | OSINT / Threat Intel | Sherlock, GitHub, Google |
| PsExec Hunt | Network Forensics | Wireshark (SMB/lateral movement) |
| PoisonedCredentials | Network Forensics | Wireshark (LLMNR poisoning) |
| WebStrike | Network Forensics | Wireshark (web shell, reverse shell) |
| The Crime | Endpoint Forensics | ALEAPP, SQLite Browser (Android) |
| Amadey - APT-C-36 | Endpoint Forensics | Volatility 3 (memory dump) |

Full writeups: [06-CTF/CyberDefenders-Profile.md](06-CTF/CyberDefenders-Profile.md)

---

## Case Studies

- [3CX Supply Chain Attack](08-Malware-Analysis/3CX-Supply-Chain-Attack.md) — DLL side-loading, C2 via steganography in .ico files, VirusTotal investigation
- [Critical Infrastructure OSINT](09-OSINT/Critical-Infrastructure-Reconnaissance.md) — ICS/SCADA attack surface, OpenStreetMap recon, wastewater facilities

---

## Tools Reference

- [Volatility 3](05-Tools/Volatility.md) — memory forensics commands and red flags
- [Wireshark](06-CTF/CyberDefenders-Network-Analysis-Wireshark.md) — filters, PCAP analysis workflow

---

## Skills

- Threat Intelligence: IOC extraction, MITRE ATT&CK mapping, sandbox analysis (ANY.RUN)
- Network Forensics: PCAP analysis, SMB/LLMNR/HTTP attack detection
- Endpoint Forensics: Windows memory analysis (Volatility), Android forensics (ALEAPP)
- OSINT: username correlation (Sherlock), GitHub credential hunting, geolocation
- Malware Analysis: static analysis, DLL side-loading, C2 infrastructure

---

## Structure

```
cybersec/
├── 00-MOC/              # Navigation
├── 01-Networking/       # Networking fundamentals
├── 02-Linux/            # Linux and bash
├── 03-Web-Security/     # OWASP, XSS, SQLi
├── 04-Cryptography/     # Encryption, hashes, TLS
├── 05-Tools/            # Volatility, Nmap, Burp Suite
├── 06-CTF/              # CyberDefenders labs and PCAP files
├── 07-Certifications/   # Certification prep
├── 08-Malware-Analysis/ # Malware case studies
├── 09-OSINT/            # OSINT research
└── 99-Inbox/            # Unsorted notes
```

---

## Sync to GitHub

```bash
cd /Users/skitus/work/cybersec
./sync.sh "description of changes"
```
