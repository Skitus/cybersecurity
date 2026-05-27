# DNS Tunneling — Data Exfiltration via DNS Queries

**File:** `pcap-files/dns_tunnel_ctf.pcapng`
**Tool:** Wireshark + terminal (base64 decode)
**Attack:** DNS tunneling / data exfiltration

---

## What Was Found

Normal DNS queries mixed with malicious exfiltration to `tunnel.evil-corp.xyz`.

The attacker encoded stolen data in base64 and sent it as DNS subdomains.
Each query = one chunk of exfiltrated data.

---

## Decoded Exfiltrated Data

Filter in Wireshark:
```
dns contains "evil-corp"
```

Each subdomain is base64. Decode in terminal:
```bash
echo "dXNlcm5hbWU6YWRtaW4=" | base64 -d    # username:admin
echo "cGFzc3dvcmQ6U3VwM3I=" | base64 -d    # password:Sup3r
echo "U2VjcjN0UGFzcyEyMDI0" | base64 -d    # Secr3tPass!2024
echo "Y3JlZGl0Y2FyZDo0MjQy" | base64 -d    # creditcard:4242
echo "NDI0MjQyNDI0MjQyNDI=" | base64 -d    # 4242424242424242  (card number)
echo "ZXhwOjEyLzI2Y3Z2OjEyMw==" | base64 -d  # exp:12/26cvv:123
echo "c3NuOjEyMy00NS02Nzg5" | base64 -d    # ssn:123-45-6789
echo "ZW1haWw6am9obkBjb3Jw" | base64 -d    # email:john@corp
```

Commands being executed remotely (C2 channel):
```bash
echo "Y21kOmxzIC1sYSAvZXRjcg==" | base64 -d   # cmd:ls -la /etc
echo "Y21kOmNhdCAvZXRjL3Bhc3N3ZA==" | base64 -d  # cmd:cat /etc/passwd
echo "Y21kOmlwY29uZmlnIC9hbGw=" | base64 -d   # cmd:ipconfig /all
```

Internal network info exfiltrated:
```bash
echo "aW50ZXJuYWxJUDoxOTI=" | base64 -d   # internalIP:192
echo "LjE2OC4xLjAvMjQ=" | base64 -d        # .168.1.0/24
echo "dmxhbjEwOmFkbWlu" | base64 -d        # vlan10:admin
```

---

## How DNS Tunneling Works

```
Normal DNS:      client → DNS server → answer (IP address)

DNS Tunnel:      client → encodes data as subdomain → sends to attacker DNS server
                 data.exfiltrated.tunnel.evil-corp.xyz
                 attacker's DNS server receives and decodes it
```

The attacker controls `evil-corp.xyz` and its DNS server.
Every query reaches them even through firewalls (port 53 is almost never blocked).

---

## How to Detect It

In Wireshark:
1. `Statistics > Protocol Hierarchy` — abnormally high % of DNS
2. Filter: `dns` → look at query names — are they unusually long?
3. Normal subdomain: `www.google.com` (short)
4. Tunnel subdomain: `dXNlcm5hbWU6YWRtaW4=.tunnel.evil-corp.xyz` (base64 blob)

Red flags:
- Subdomains longer than 30-40 characters
- Base64 pattern in subdomains (letters, numbers, `=` at end)
- High volume of TXT record queries
- All queries going to one unusual domain

---

## What Was Stolen in This File

- Admin credentials
- Credit card: `4242424242424242`, exp `12/26`, cvv `123`
- SSN: `123-45-6789`
- Internal network map: `192.168.1.0/24`, VLAN 10 credentials
- Command output from the victim machine
