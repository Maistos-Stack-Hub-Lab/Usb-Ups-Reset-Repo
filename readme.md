# usb-ups-reset

Automatic USB reset and monitoring tools for CyberPower UPS devices when status issues occur, such as "Anomalous" or unrecognized battery mode. This project is designed for QNAP, Synology, and generic Linux systems and includes full support for cron jobs, SNMP, NUT, Slack notifications, syslog, and Docker-based development/testing environments.

## 🌍 Supported Platforms
- QNAP NAS (BusyBox shell)
- Synology NAS (DSM 6/7 with shell access)
- Generic Linux distros (Debian, Ubuntu, etc.)

## 🔧 What It Does
- Detects CyberPower UPS devices connected via USB
- Performs USB reset upon detecting fault conditions
- Monitors UPS status using `upsc` (NUT) or `snmpget`
- Sends alerts to Slack on errors
- Supports logging to files and syslog
- Can be run via scheduled cron jobs

## 📁 Repository Structure
```
usb-ups-reset/
├── README.md
├── LICENSE
├── .gitignore
├── common/
│   ├── detect_usb_id.sh
│   ├── check_ups_nut.sh
│   ├── check_ups_snmp.sh
│   └── notify_slack.sh
├── qnap/
│   └── ups_reset_cron_qnap.sh
├── synology/
│   └── ups_reset_cron_synology.sh
├── linux/
│   └── ups_reset_cron_generic.sh
├── crontab_examples/
│   └── crontab_entry.md
├── Dockerfile
└── docker-compose.yml
```

## 📦 Installation
```bash
git clone https://github.com/yourname/usb-ups-reset.git
cd usb-ups-reset
chmod +x */*.sh
```

## 🔁 Cronjob Example
Add to crontab (`crontab -e`):
```bash
*/10 * * * * /path/to/usb-ups-reset/qnap/ups_reset_cron_qnap.sh
```

## ✅ Requirements
- BusyBox or bash shell
- Write permission to log directory
- Optional: `net-snmp`, `nut-client`, `jq`, `curl`

## 📊 UPS Status Detection
- **NUT example:** `common/check_ups_nut.sh`
- **SNMP example:** `common/check_ups_snmp.sh`

## 📣 Slack Webhook Integration
- `common/notify_slack.sh` allows sending alerts to Slack.
- Requires valid webhook URL and `jq` installed.

## 🐋 Docker Development Environment
Build and run with Docker:
```bash
docker-compose build
docker-compose up -d
```
Useful for testing detection, logging, and scripting in isolation.

## 🧪 Testing
- Test USB detection: `bash test/test_detect.sh`
- Simulate reset conditions in Docker

## 🖼️ Screenshots & Setup Examples
- Setup screenshots in `/docs/screenshots/`
- Embedded examples in documentation

## 📝 License
Licensed under the [MIT License](LICENSE)

---

For contributions, bug reports or suggestions, please open an issue or pull request on GitHub.
