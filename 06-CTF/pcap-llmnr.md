# LLMNR Poisoning — NTLMv2 Hash Capture

**File:** `pcap-files/llmnr_practice.pcapng`
**Tool:** Wireshark
**Attack:** LLMNR/NBT-NS poisoning (Responder attack)

---

## What Happened

Two Windows machines tried to access servers with typos in the hostname.
Because DNS couldn't resolve the names, Windows fell back to LLMNR (multicast).
An attacker on the network (Responder) answered every LLMNR request and captured NTLMv2 hashes.

---

## Attack Flow Visible in the PCAP

**Victim 1:**
```
DNS query: FILESERVRE   ← typo (should be FILESERVER)
DNS response: no answer
→ Windows sends LLMNR multicast: "who is FILESERVRE?"
→ Attacker (Responder) replies: "that's me"
→ ACCOUNTINGPC authenticates as MARKETING\johndoe
→ NTLMv2 hash captured
```

**Victim 2:**
```
DNS query: PRNTSERVER
→ LLMNR multicast
→ Rogue Responder replies
→ HR-Desktop authenticates as HR\sarahjones
→ NTLMv2 hash captured
```

---

## Wireshark Analysis

**Step 1 — Find LLMNR traffic:**
```
llmnr
```

**Step 2 — Find NTLM authentication:**
```
ntlmssp
```

**Step 3 — Extract captured hashes:**

Look for packets with `NTLMSSP_AUTH` — this contains the NTLMv2 response.
Right-click → Follow → TCP Stream

From the file — visible domain\user info:
```
MARKETING\johndoe   from ACCOUNTINGPC
HR\sarahjones       from HR-Desktop
```

**Step 4 — Format hash for hashcat:**

NTLMv2 hash format for cracking:
```
username::domain:challenge:NTresponse:NTblobhash
```

Crack with hashcat:
```bash
hashcat -m 5600 hashes.txt wordlist.txt
```

---

## Why LLMNR Is Dangerous

1. Windows tries DNS first
2. If DNS fails → broadcasts LLMNR to the entire network
3. Anyone on the network can respond
4. The victim automatically authenticates to whoever responds first
5. Attacker gets NTLMv2 hash → crack offline or relay to another service

**Tool used by attackers:** Responder (`python3 Responder.py -I eth0`)

---

## Defense

- Disable LLMNR via Group Policy: `Computer Config → Admin Templates → Network → DNS Client → Turn off multicast name resolution = Enabled`
- Disable NetBIOS over TCP/IP on all adapters
- Use SMB signing to prevent relay attacks
