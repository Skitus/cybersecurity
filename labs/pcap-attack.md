# SSH Brute Force — Port Scan + Credential Stuffing

**File:** `pcap-files/attack_ctf.pcapng`
**Tool:** Wireshark
**Attack:** SSH port scan + brute force via libssh2

---

## What Was Found

### Phase 1 — Port Scan on SSH (port 22)

Many SYN packets from one source to multiple IPs on port 22.
This is a network scan to find which machines have SSH open.

Filter in Wireshark:
```
tcp.flags.syn == 1 && tcp.flags.ack == 0 && tcp.dstport == 22
```

Server response when SSH is open:
```
SSH-2.0-OpenSSH_8.9
```

---

### Phase 2 — SSH Brute Force

After finding open SSH servers, the attacker tries common passwords.
The attacker embeds the password attempt in the SSH client version string (libssh2 behavior):

```
SSH-2.0-libssh2_attempt_admin
SSH-2.0-libssh2_attempt_password
SSH-2.0-libssh2_attempt_123456
SSH-2.0-libssh2_attempt_root
SSH-2.0-libssh2_attempt_letmein
SSH-2.0-libssh2_attempt_welcome
SSH-2.0-libssh2_attempt_monkey
SSH-2.0-libssh2_attempt_dragon
SSH-2.0-libssh2_attempt_master
SSH-2.0-libssh2_attempt_abc123
```

Filter in Wireshark:
```
ssh.protocol contains "libssh2"
```

Each attempt = new TCP connection → SSH banner exchange → disconnect.

---

## Detecting Brute Force in Wireshark

Signs of brute force:
- Many short SSH connections from one IP to one target
- Each connection lasts less than 1-2 seconds
- SSH version string contains tool name (libssh2, paramiko, etc.)

Filter to count connections:
```
tcp.dstport == 22 && tcp.flags.syn == 1
```
Use `Statistics > Conversations` to see how many connections per IP pair.

---

## Credentials Being Tested

This is a dictionary attack using common passwords:
`admin, password, 123456, root, letmein, welcome, monkey, dragon, master, abc123`

These are all in rockyou.txt — the standard password wordlist.

---

## Key Indicators of Compromise

- Source IP making 10+ SSH connections per second
- libssh2/paramiko in SSH version string (automation tools, not human)
- Rapid sequential connections to same target port
- Multiple different source IPs → distributed brute force (botnet)
