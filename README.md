# Cybersecurity Notes

Personal lab notes and writeups.
Profile: https://cyberdefenders.org/p/artur.demenskiy03/

---

## PCAP Analysis Labs

Real network captures analyzed in Wireshark.

| Lab | Attack | Tools |
|---|---|---|
| [CTF Challenge](06-CTF/pcap-ctf-challenge.md) | FTP/HTTP/Telnet cleartext | Wireshark |
| [DNS Tunnel](06-CTF/pcap-dns-tunnel.md) | Data exfil via DNS base64 | Wireshark, base64 |
| [Web Attack](06-CTF/pcap-webattack.md) | SQLi + .env leak | Wireshark, sqlmap |
| [LLMNR Poisoning](06-CTF/pcap-llmnr.md) | NTLMv2 hash capture | Wireshark, hashcat |
| [SSH Brute Force](06-CTF/pcap-attack.md) | Port scan + credential stuffing | Wireshark |
| [WiFi Attack](06-CTF/pcap-wifi.md) | Deauth + WPA2 handshake | Wireshark, hashcat |
| [Malware C2](06-CTF/pcap-malware.md) | C2 beaconing detection | Wireshark |
| [VoIP](06-CTF/pcap-voip.md) | SIP/RTP call interception | Wireshark |

---

## CyberDefenders Labs — 9 Completed

[Full writeups](06-CTF/CyberDefenders-Profile.md)

Red Stealer, Yellow RAT, Oski, Lespion, PsExec Hunt, PoisonedCredentials, WebStrike, The Crime, Amadey APT-C-36

---

## Case Studies

- [3CX Supply Chain Attack](08-Malware-Analysis/3CX-Supply-Chain-Attack.md)
- [Critical Infrastructure OSINT](09-OSINT/Critical-Infrastructure-Reconnaissance.md)

---

## Tools

- [Volatility 3](05-Tools/Volatility.md) — memory forensics

---

## Sync

```bash
cd /Users/skitus/work/cybersec && ./sync.sh "description"
```
