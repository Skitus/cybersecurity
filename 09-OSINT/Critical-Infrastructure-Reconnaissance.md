# Critical Infrastructure Reconnaissance — OSINT Research

**Date studied:** 2025-05
**Category:** OSINT / Reconnaissance / ICS Security
**Context:** Educational research — understanding attack surface of critical infrastructure
**Status:** Completed

---

## Objective

Understand how attackers identify and map critical infrastructure targets using open-source intelligence.
This is the reconnaissance phase — what an attacker does before any actual attack.
Defensive value: knowing what is publicly visible helps defenders reduce exposure.

---

## What Was Done

- Researched wastewater treatment facilities (water/sewage infrastructure) as an example of critical infrastructure
- Used OpenStreetMap to locate and identify infrastructure objects geographically
- Analyzed what information is publicly accessible about these facilities
- Studied how critical infrastructure is categorized and why it is a high-value target

---

## What Is Critical Infrastructure

Critical infrastructure = systems so essential that their disruption causes widespread harm:

| Sector | Examples |
|---|---|
| Water | Wastewater treatment plants, pumping stations, reservoirs |
| Energy | Power grids, substations, pipelines |
| Transport | Railways, airports, ports |
| Finance | Banking systems, payment networks |
| Healthcare | Hospitals, emergency services |

Wastewater treatment plants specifically:
- Receive sewage from homes and factories
- Process it through mechanical and biological stages (bacteria-based)
- Release clean water back into rivers/environment
- Run on industrial control systems (ICS/SCADA)

---

## OSINT Techniques Used

**OpenStreetMap (OSM)**
- Free, open geographic database
- Shows industrial facilities, water infrastructure, roads
- Used to locate facilities and understand physical layout
- No authentication required — fully public

**What attackers look for:**
- Physical location (for physical intrusion or drone reconnaissance)
- Connected network infrastructure (IT/OT network exposure)
- Vendor equipment visible in public photos (Shodan cross-reference)
- Employee names and roles (LinkedIn, company websites)

---

## Why This Matters (ICS/SCADA Security)

Industrial Control Systems (ICS) at water facilities often:
- Run outdated Windows versions (XP, 7)
- Are not patched regularly (uptime is prioritized)
- Have direct internet connections (legacy remote access)
- Use default credentials on HMI interfaces

Real-world incidents:
- 2021 Oldsmar, Florida — attacker raised sodium hydroxide levels via TeamViewer
- 2020 Israel water treatment attacks (Iran-attributed)

---

## Tools for Infrastructure OSINT

| Tool | Purpose |
|---|---|
| OpenStreetMap | Geographic mapping of facilities |
| Shodan | Find internet-exposed ICS devices |
| Censys | Similar to Shodan, broader SSL/TLS data |
| Google Maps / Satellite | Physical layout reconnaissance |
| LinkedIn | Employee enumeration |

---

## Key Takeaway

The reconnaissance phase requires no hacking. Everything here is public information.
The defender's job is to minimize what is visible and accessible from outside.

---

## References

- [ICS-CERT Advisories](https://www.cisa.gov/ics-advisories)
- [Shodan ICS Search](https://www.shodan.io/explore/category/industrial-control-systems)
- [2021 Oldsmar Water Attack](https://www.cisa.gov/news-events/alerts/2021/02/10/compromise-u.s-water-treatment-facility)
