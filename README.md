# Cybersecurity Notes

Personal knowledge base. Notes from labs, real-world case studies, and research.
Written in Obsidian, synced to GitHub.

---

## Completed Work

### Malware Analysis
- **3CX Supply Chain Attack** — analyzed trojanized `ffmpeg.dll`, traced C2 communication via `.ico` files on GitHub, VirusTotal investigation

### Network Forensics
- **Wireshark + CyberDefenders** — network traffic analysis using `.pcap` dumps, Amaury lab on CyberDefenders platform

### OSINT / Reconnaissance
- **Critical Infrastructure Research** — mapped wastewater treatment facilities using OpenStreetMap, studied ICS/SCADA attack surface

---

## Structure

```
cybersec/
├── 00-MOC/              # Navigation notes
├── 01-Networking/       # Networking fundamentals
├── 02-Linux/            # Linux and bash
├── 03-Web-Security/     # OWASP, XSS, SQLi, CSRF
├── 04-Cryptography/     # Encryption, hashes, TLS
├── 05-Tools/            # Nmap, Burp Suite, Metasploit
├── 06-CTF/              # CTF writeups and lab notes
├── 07-Certifications/   # Certification prep
├── 08-Malware-Analysis/ # Malware samples and case studies
├── 09-OSINT/            # Open-source intelligence
└── 99-Inbox/            # Quick notes to sort later
```

---

## Platforms Used

- [CyberDefenders](https://cyberdefenders.org) — blue team labs
- [TryHackMe](https://tryhackme.com) — guided learning paths
- [VirusTotal](https://www.virustotal.com) — file and URL analysis

---

## How to Sync

```bash
cd /Users/skitus/work/cybersec
./sync.sh "brief description of what was added"
```
