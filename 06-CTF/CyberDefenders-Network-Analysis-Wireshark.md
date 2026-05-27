# CyberDefenders — Network Traffic Analysis with Wireshark

**Date studied:** 2025-05
**Platform:** CyberDefenders (cyberdefenders.org)
**Lab:** Amaury (Network Forensics)
**Category:** Network Forensics / Blue Team / Traffic Analysis
**Difficulty:** Beginner–Intermediate
**Status:** In Progress

---

## What This Is

CyberDefenders is a blue team training platform with real-world forensics labs.
The Amaury lab focuses on network traffic analysis using pre-captured `.pcap` dump files.
Goal: answer specific questions by analyzing what happened on the network.

---

## What Was Done

- Set up Wireshark on local machine
- Worked with a pre-captured network dump (`.pcap` file)
- Two approaches used:
  - **Option A** — continued the Amaury lab directly on CyberDefenders (dump already available in the platform)
  - **Option B** — downloaded the dump file locally and analyzed in Wireshark

---

## Wireshark Basics Practiced

**Filters used:**

```
# Filter by IP
ip.addr == 192.168.1.1

# Filter by protocol
tcp
udp
http
dns

# Filter by port
tcp.port == 80
tcp.port == 443

# Follow a TCP stream
Right-click a packet > Follow > TCP Stream

# Find credentials in plain HTTP
http.request.method == "POST"
```

**Key Wireshark features:**
- Statistics > Protocol Hierarchy — see what protocols are in the capture
- Statistics > Conversations — see which IPs were talking to each other
- File > Export Objects > HTTP — extract files transferred over HTTP
- Follow TCP/UDP Stream — reconstruct full conversations

---

## What to Look For in a Network Dump

| Indicator | What It Means |
|---|---|
| DNS queries to unknown domains | Possible C2 beaconing |
| Large data uploads (POST requests) | Possible data exfiltration |
| Connections to unusual ports | Backdoor or tunneling |
| Repeated requests at fixed intervals | Malware heartbeat / beacon |
| Unencrypted credentials | HTTP Basic Auth, FTP, Telnet |

---

## Key Concepts Learned

**PCAP Analysis Workflow:**
1. Open dump in Wireshark
2. Check Statistics > Protocol Hierarchy (understand the traffic mix)
3. Check Statistics > Conversations (find the main IPs involved)
4. Filter by suspicious protocols or ports
5. Follow streams to reconstruct what happened
6. Export files if needed

**Blue Team vs Red Team:**
- Red Team (attacker) creates the traffic
- Blue Team (defender) analyzes it after the fact
- SOC analysts do this daily with real enterprise traffic

---

## Tools Used

| Tool | Purpose |
|---|---|
| Wireshark | Primary traffic analysis tool |
| CyberDefenders platform | Lab environment and questions |
| tshark | Command-line version of Wireshark (for scripting) |

---

## References

- [CyberDefenders](https://cyberdefenders.org)
- [Wireshark Documentation](https://www.wireshark.org/docs/)
- [Wireshark Display Filters Reference](https://www.wireshark.org/docs/dfref/)
