# Synology Integration – USB UPS Reset Toolkit

Diese Anleitung erklärt, wie Sie das Toolkit auf einem Synology NAS mit CyberPower USV per USB einsetzen können.

---

## 🛠 Voraussetzungen

- Synology NAS mit DSM 6.x oder 7.x
- CyberPower USV via USB verbunden
- Admin-Zugriff via SSH

---

## 🔍 Problemstellung

Nach längerem Betrieb oder bei IPv6-/DSM-Änderungen kann die USV im DSM-Interface als "nicht verbunden" erscheinen oder wird falsch erkannt.

---

## ✅ Lösung

### 1. Repository klonen

```bash
cd /volume1/homes/admin
git clone https://github.com/Maistos-Stack-Hub-Lab/Usb-Ups-Reset-Repo.git
cd Usb-Ups-Reset-Repo
chmod +x synology/*.sh
