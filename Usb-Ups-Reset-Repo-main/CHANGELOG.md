# Changelog – USB UPS Reset Toolkit

Alle wichtigen Änderungen an diesem Projekt werden in diesem Dokument festgehalten.

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

