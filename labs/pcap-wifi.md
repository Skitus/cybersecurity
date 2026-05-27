# WiFi Attack — Deauth + WPA2 Handshake Capture

**File:** `pcap-files/wifi_ctf.pcapng`
**Tool:** Wireshark
**Attack:** Deauthentication attack → WPA2 handshake capture

---

## What Was Found

### Networks Visible (Beacon Frames)

```
HomeNetwork_5G
OfficeWiFi
Kyivstar_Guest
```

Filter in Wireshark:
```
wlan.fc.type_subtype == 8
```
(subtype 8 = Beacon frames)

---

### Probe Requests — Device Location History

Before connecting to a network, devices broadcast probe requests for previously known networks.
This reveals where the device has been.

From the capture:
```
Device probed for: HomeNetwork_5G
Device probed for: Starbucks
Device probed for: KLM_WIFI
```

This reveals the device owner was at: home, Starbucks coffee shop, on KLM flight.

Filter in Wireshark:
```
wlan.fc.type_subtype == 4
```
(subtype 4 = Probe Request)

---

### Deauthentication Attack

A flood of deauth frames sent to broadcast address (kicks everyone off OfficeWiFi):
```
Source: attacker MAC
Destination: ff:ff:ff:ff:ff:ff (broadcast)
Frame type: Deauthentication
Reason: 7 (Class 3 frame received from nonassociated station)
```

This is a WiFi DoS attack. Forces all clients to reconnect.
When clients reconnect → WPA2 4-way handshake is captured.

Filter in Wireshark:
```
wlan.fc.type_subtype == 12
```
(subtype 12 = Deauthentication)

---

### WPA2 4-Way Handshake Captured

After the deauth, clients reconnect and the handshake is captured.
The handshake contains enough data to crack the password offline.

Filter in Wireshark:
```
eapol
```
(EAPOL = 802.1X authentication, used in WPA2 handshake)

You need all 4 packets (messages 1-4) to crack.

**Crack the password:**
```bash
# Convert to hashcat format
hcxpcapngtool -o wifi.hc22000 wifi_ctf.pcapng

# Crack with hashcat
hashcat -m 22000 wifi.hc22000 rockyou.txt
```

Or with aircrack-ng:
```bash
aircrack-ng wifi_ctf.pcapng -w rockyou.txt
```

---

## Attack Flow Summary

```
1. Attacker puts WiFi adapter in monitor mode
2. Sees target: OfficeWiFi
3. Sends deauth frames → all clients disconnect
4. Clients reconnect → 4-way handshake captured
5. Crack handshake offline with wordlist
6. Get WiFi password → full network access
```

---

## Key Facts

- Deauth attack works on WPA2 (no fix without WPA3)
- WPA3 adds protection against offline cracking (SAE handshake)
- Probe requests are public — any passive listener sees them
- To protect: disable SSID broadcast does nothing, use WPA3, enable Management Frame Protection (802.11w)
