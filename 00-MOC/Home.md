# Home

---

## PCAP Labs — Wireshark Analysis

| File | Attack | Key Finding |
|---|---|---|
| [[../06-CTF/pcap-ctf-challenge\|ctf-challenge]] | Cleartext protocols | FTP/HTTP/Telnet credentials |
| [[../06-CTF/pcap-dns-tunnel\|dns-tunnel]] | DNS exfiltration | Credit card, SSN, commands via base64 DNS |
| [[../06-CTF/pcap-webattack\|webattack]] | SQLi + path traversal | sqlmap, .env leak (DB_PASS=SuperSecret123) |
| [[../06-CTF/pcap-llmnr\|llmnr]] | LLMNR poisoning | NTLMv2 hashes for johndoe, sarahjones |
| [[../06-CTF/pcap-attack\|attack]] | SSH brute force | libssh2, 10 password attempts |
| [[../06-CTF/pcap-wifi\|wifi]] | Deauth + handshake | WPA2 crack-ready capture |
| [[../06-CTF/pcap-malware\|malware]] | C2 beaconing | d4rk-upd4te.xyz, periodic encrypted calls |
| [[../06-CTF/pcap-voip\|voip]] | VoIP interception | SIP call "Secret Meeting", RTP audio |

---

## CyberDefenders — 9 Labs Completed

Profile: https://cyberdefenders.org/p/artur.demenskiy03/

Full writeups: [[../06-CTF/CyberDefenders-Profile]]

---

## Case Studies

- [[../08-Malware-Analysis/3CX-Supply-Chain-Attack|3CX Supply Chain Attack]] — DLL side-loading, C2 via .ico files
- [[../09-OSINT/Critical-Infrastructure-Reconnaissance|Critical Infrastructure OSINT]] — wastewater facilities, OpenStreetMap, Shodan

---

## Tools Reference

- [[../05-Tools/Volatility|Volatility 3]] — memory forensics commands
