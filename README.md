# Cybersecurity Notes

https://cyberdefenders.org/p/artur.demenskiy03/

---

## PCAP Labs — Wireshark

Real network captures. Download from `labs/pcap-files/` and open in Wireshark.

| File | Attack |
|---|---|
| [ctf-challenge](labs/pcap-ctf-challenge.md) | FTP/HTTP/Telnet cleartext credentials |
| [dns-tunnel](labs/pcap-dns-tunnel.md) | Data exfiltration via base64 DNS queries |
| [webattack](labs/pcap-webattack.md) | SQLi with sqlmap + .env file exposed |
| [llmnr](labs/pcap-llmnr.md) | LLMNR poisoning — NTLMv2 hash capture |
| [attack](labs/pcap-attack.md) | SSH port scan + brute force |
| [wifi](labs/pcap-wifi.md) | Deauth attack + WPA2 handshake |
| [malware](labs/pcap-malware.md) | C2 beaconing to d4rk-upd4te.xyz |
| [voip](labs/pcap-voip.md) | SIP call interception + RTP audio |

---

## CyberDefenders — 9 Labs

[Full writeups](labs/CyberDefenders-Profile.md)

Red Stealer · Yellow RAT · Oski · Lespion · PsExec Hunt · PoisonedCredentials · WebStrike · The Crime · Amadey APT-C-36

---

## Malware Analysis

[3CX Supply Chain Attack](malware/3CX-Supply-Chain-Attack.md)

---

## Tools

[Volatility 3](tools/Volatility.md)

---

```bash
cd /path/to/cybersec && ./sync.sh "description"
```
