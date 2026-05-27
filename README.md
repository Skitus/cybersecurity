# 🔐 Cybersecurity Notes

Персональная база знаний по кибербезопасности.  
Ведётся в [Obsidian](https://obsidian.md), синхронизируется с GitHub.

## 📁 Структура

```
cybersec/
├── 00-MOC/              # Maps of Content — навигационные заметки
├── 01-Networking/       # Сети: TCP/IP, DNS, HTTP, Wireshark
├── 02-Linux/            # Linux: команды, bash, права доступа
├── 03-Web-Security/     # OWASP Top 10, XSS, SQLi, CSRF
├── 04-Cryptography/     # Шифрование, хэши, PKI, TLS
├── 05-Tools/            # Nmap, Burp Suite, Metasploit, etc.
├── 06-CTF/              # CTF writeups и задания
├── 07-Certifications/   # Подготовка к сертификациям (CEH, OSCP...)
└── 99-Inbox/            # Быстрые заметки (разобрать позже)
```

## 🚀 Как синхронизировать

```bash
# Быстрое сохранение всего
./sync.sh "описание изменений"

# Или вручную
git add .
git commit -m "update notes"
git push
```

## 📚 Ресурсы

- [TryHackMe](https://tryhackme.com)
- [HackTheBox](https://hackthebox.com)
- [PortSwigger Web Security Academy](https://portswigger.net/web-security)
- [OWASP](https://owasp.org)
