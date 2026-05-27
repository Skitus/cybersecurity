# VoIP Interception — SIP Call + RTP Audio Extraction

**File:** `pcap-files/voip_ctf.pcapng`
**Tool:** Wireshark
**Protocol:** SIP (signaling) + RTP (audio)

---

## What Was Found

A complete phone call between Alice and Bob, unencrypted.
Call subject visible in SIP headers: **"Secret Meeting"**

---

## SIP Call Setup (Visible in PCAP)

```
Alice (192.168.1.10) → Bob (192.168.1.20)

INVITE sip:bob@192.168.1.20
  From: Alice <sip:alice@company.com>
  To: Bob <sip:bob@company.com>
  Call-ID: a84b4c76e66710@192.168.1.10
  Session name: Secret Meeting
  Audio port: 49170, codec: PCMU/8000

← 100 Trying
← 180 Ringing
← 200 OK
  Bob's audio port: 49180

→ ACK  (call established)

... RTP audio stream ...

← BYE  (Bob hangs up)
→ 200 OK
```

---

## Wireshark Analysis

**Step 1 — See all SIP messages:**
```
sip
```

**Step 2 — Follow the call flow:**
```
Telephony > VoIP Calls
```
Shows all calls in the capture with start/end time, parties, duration.

**Step 3 — Extract the audio:**
```
Telephony > RTP > RTP Streams
```
Select the stream → Analyze → Save audio as `.wav`

**Step 4 — Play the call:**
After saving as `.wav` — open in any audio player.
The actual conversation is now recovered.

---

## Key Information Extracted

| Field | Value |
|---|---|
| Caller | Alice, sip:alice@company.com, 192.168.1.10 |
| Receiver | Bob, sip:bob@company.com, 192.168.1.20 |
| Call ID | a84b4c76e66710@192.168.1.10 |
| Session name | Secret Meeting |
| Audio codec | PCMU (G.711), 8000 Hz |
| Audio ports | Alice: 49170, Bob: 49180 |

---

## Why This Works

SIP itself is plaintext (like HTTP).
RTP carries the actual audio — also unencrypted by default.

On any network where you can capture traffic (internal LAN, WiFi), you can:
1. Capture PCAP
2. Open in Wireshark
3. Extract and play any SIP/RTP calls

**Secure alternative:** SRTP (Secure RTP) + TLS for SIP signaling.
Most modern VoIP systems (Zoom, Teams, Signal) use end-to-end encryption — not interceptable this way.

---

## Filters Summary

```
sip                          # All SIP messages
rtp                          # All RTP audio packets
sip.Method == "INVITE"       # Only call setup
sip.Method == "BYE"          # Only call teardown
```
