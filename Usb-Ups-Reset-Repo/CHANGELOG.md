# Changelog – USB UPS Reset Toolkit

Alle wichtigen Änderungen an diesem Projekt werden in diesem Dokument festgehalten.

---
## [v1.3.0] – 2025-05-01

### ✨ New Features
- **QNAP Support Added**  
  - `common/detect_usb_id_qnap.sh`: Detects CyberPower USB devices (Vendor ID 0764) with logging  
  - `qnap/ups_reset_cron_qnap_optimized.sh`: Resets only the UPS, not all USB devices  
  - `docs/qnap.md`: New usage guide for QNAP NAS integration  
  - 📣 Community contribution by Frank Templer (frank@templer.de)

- **Synology NAS Support Added**  
  - `docs/synology.md`: Step-by-step guide for Synology DSM and UPS reset via cron

### 📝 Documentation
- `README.md` updated with:
  - New QNAP and Synology usage sections
  - Repository structure updated
  - Community credits added

### 🐛 Fixes & Maintenance
- Line ending warnings resolved via CRLF-LF normalization
- Improved file and logging consistency for all UPS reset paths

---

## [v1.2.0] – 2025-05-15

### Neu
- **QNAP-optimierte Skripte hinzugefügt**:
  - `common/detect_usb_id_qnap.sh`: Loggt erkannte UPS-IDs mit Zeitstempel.
  - `qnap/ups_reset_cron_qnap_optimized.sh`: Führt gezielten USB-Reset nur für die erkannte UPS durch.
- Dokumentation aktualisiert (`docs/index.md`):
  - Neuer Abschnitt „QNAP-Spezialvariante“ mit Anleitungen zu den neuen Skripten.

### 🛠 Verbesserungen
- Log-Ausgaben zur besseren Nachvollziehbarkeit der Skriptaktivität.
- Mehr Plattformkompatibilität (getestet auf mehreren QNAPs mit BR1200ELCD).

---

## [v1.1.0] – 2025-04-25

### Neue Funktionen
- Erste Version von `detect_usb_id.sh` und `ups_reset_cron_qnap.sh`
- Unterstützung für QNAP, Synology und Linux-Systeme
- Integration mit Slack-Webhooks für Statusmeldungen
- Erste GitHub Actions Workflows eingerichtet (CI & GHCR)

---

## [v1.0.0] – 2025-04-20

- Initiale Projektveröffentlichung auf GitHub
- Grundfunktionen: UPS-Erkennung & einfacher Reset über USB-ID
- Basis-Dokumentation erstellt

