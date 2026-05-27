# CTF Challenge — Multi-Protocol Credential Capture

**File:** `pcap-files/ctf_challenge.pcapng`
**Tool:** Wireshark
**Protocols found:** FTP, HTTP, Telnet

---

## What Was Found

### 1. FTP — Cleartext Login

```
Server: ProFTPD 1.3.5
USER john_admin
PASS Sup3rS3cr3t!
230 User john_admin logged in.
```

FTP sends credentials in plaintext. Filter in Wireshark:
```
ftp
```
Follow TCP Stream → see full login sequence.

---

### 2. HTTP — Basic Auth Decoded

Request to `/admin/panel`:
```
Authorization: Basic YWRtaW46UEBzc3cwcmQjMjAyNA==
```

Decode base64 in terminal:
```bash
echo "YWRtaW46UEBzc3cwcmQjMjAyNA==" | base64 -d
# Output: admin:P@ssw0rd#2024
```

Filter in Wireshark:
```
http.authorization
```

---

### 3. HTTP — POST Login Form

```
POST /login HTTP/1.1
Host: mail.corp-internal.com

username=alice%40company.com&password=qwerty1234&remember=true
```

Filter:
```
http.request.method == "POST"
```
Then follow TCP Stream to see full POST body.

---

### 4. Telnet — Root Login in Plaintext

```
Ubuntu 20.04 LTS
login: root
Password: toor2024
# cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
```

Telnet has zero encryption — entire terminal session visible.
Filter:
```
telnet
```
Follow TCP Stream → read the full shell session.

---

### 5. Anonymous FTP

```
USER anonymous
PASS anonymous@
230 Anonymous login ok.
```

Server allows anonymous access — common misconfiguration on internal file shares.

---

## Credentials Captured

| Protocol | Username | Password |
|---|---|---|
| FTP | john_admin | Sup3rS3cr3t! |
| HTTP Basic | admin | P@ssw0rd#2024 |
| HTTP POST | alice@company.com | qwerty1234 |
| Telnet | root | toor2024 |
| FTP | anonymous | anonymous@ |

---

## Key Lesson

All of these protocols transmit credentials in cleartext.
Any attacker with network access (or a PCAP) can read them directly.
Modern equivalents: SFTP instead of FTP, HTTPS instead of HTTP, SSH instead of Telnet.
