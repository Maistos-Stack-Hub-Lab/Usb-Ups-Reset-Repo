# usb-ups-reset

Automatic USB reset and monitoring tools for CyberPower UPS devices when status issues occur, such as "Anomalous" or unrecognized battery mode. This project is designed for QNAP, Synology, and generic Linux systems and includes full support for cron jobs, SNMP, NUT, Slack notifications, syslog, and Docker-based development/testing environments.

##  Supported Platforms
- QNAP NAS (BusyBox shell)
- Synology NAS (DSM 6/7 with shell access)
- Generic Linux distros (Debian, Ubuntu, etc.)

##  What It Does
- Detects CyberPower UPS devices connected via USB
- Performs USB reset upon detecting fault conditions
- Monitors UPS status using `upsc` (NUT) or `snmpget`
- Sends alerts to Slack on errors
- Supports logging to files and syslog
- Can be run via scheduled cron jobs

#### Scenario: QNAP NAS fails to detect CyberPower UPS

**Problem**: After a firmware update, a QNAP NAS intermittently reports UPS as "Anomalous".

**Solution**:
1. Clone this repo to your NAS or shared folder.
2. Make the detection script executable:
```bash
chmod +x common/detect_usb_id.sh
```
3. Add to crontab for every 10 minutes:
```bash
*/10 * * * * /path/to/common/detect_usb_id.sh >> /var/log/ups-check.log 2>&1
```
4. Optional: Configure Slack alerts using `notify_slack.sh`

**Outcome**: UPS communication is automatically reset, preventing shutdown errors and improving uptime reliability.

## QNAP Optimization (Community Contribution)

Special thanks to community contributor **Frank cypow@frankberger.de** for this extension:

- `custom/dui_qnap_custom.sh`: Detects only CyberPower devices (Vendor-ID 0764) with logging
- `custom/ups_reset_cron_qnap_cut7.sh`: Resets only the detected UPS, not all USB devices

⚠ These scripts are **optional** but recommended for QNAP NAS with CyberPower UPS.

### Logs
- `/tmp/usb_detect.log` – Results from UPS detection
- `/tmp/ups_reset_custom.log` – Actions taken by the UPS reset script

## Repository Structure
```
usb-ups-reset/
├── .github/
│   ├── workflows/
│   │   ├── ups-toolkit-ci.yml
│   │   └── deploy-ghcr-k8s.yml
│   │   └── test-qnap-custom.yml
│   ├── ISSUE_TEMPLATE.md
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── CONTRIBUTING.md
├── README.md
├── CHANGELOG.md
├── VERSION
├── LICENSE
├── Dockerfile
├── docker-compose.yml
├── k8s/
│   └── deployment.yaml
├── docs/
│   ├── qnap.md
│   ├── synology.md
│   └── usage.md
├── common/
│   ├── detect_usb_id.sh
│   ├── detect_usb_id_qnap.sh             
│   ├── check_ups_nut.sh
│   ├── check_ups_snmp.sh
```
## Installation
```bash
git clone https://github.com/Maistos-Stack-Hub-Lab/Usb-Ups-Reset-Repo.git
cd Usb-Ups-Reset-Repo
chmod +x */*.sh
```

## Cronjob Example
Add to crontab (`crontab -e`):
```bash
*/10 * * * * /path/to/usb-ups-reset/qnap/ups_reset_cron_qnap.sh
```

## Requirements
- BusyBox or bash shell
- Write permission to log directory
- Optional: `net-snmp`, `nut-client`, `jq`, `curl`

## UPS Status Detection
- **NUT example:** `common/check_ups_nut.sh`
- **SNMP example:** `common/check_ups_snmp.sh`

## Slack Webhook Integration
- `common/notify_slack.sh` allows sending alerts to Slack.
- Requires valid webhook URL and `jq` installed.

RUN apt update && apt install -y usbutils curl jq bash

COPY . /app
WORKDIR /app

CMD ["bash"]
```

### docker-compose.yml
Run locally:
```bash
docker-compose up --build -d
```

## Kubernetes Deployment (Example)
**To be created**: Save the following as `k8s/deployment.yaml`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ups-toolkit
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ups-toolkit
  template:
    metadata:
      labels:
        app: ups-toolkit
    spec:
      containers:
      - name: ups-toolkit
        image: ghcr.io/your-org/ups-toolkit:latest
        volumeMounts:
        - mountPath: "/app/logs"
          name: logs
        command: ["/bin/bash", "-c", "./common/detect_usb_id.sh && sleep infinity"]
      volumes:
      - name: logs
        emptyDir: {}
```

Apply with:
```bash
kubectl apply -f k8s/deployment.yaml
```

## Securing CI with Google Cloud Secret Manager
- Store your SSH keys or Slack webhooks securely
- Use `google-github-actions/auth` + `gcloud secrets versions access`
- Example step in workflow:
```yaml
- id: 'auth'
  uses: 'google-github-actions/auth@v1'
  with:
    credentials_json: '${{ secrets.GCP_CREDENTIALS }}'

- name: Access secret
  run: |
    SLACK_WEBHOOK=$(gcloud secrets versions access latest --secret="slack-webhook-url")
    echo "::add-mask::$SLACK_WEBHOOK"
    echo "SLACK_WEBHOOK=$SLACK_WEBHOOK" >> $GITHUB_ENV
```

This setup is now fully CI/CD-capable for Docker, Kubernetes, and enterprise secret management via Google Cloud!

## Testing
- Test USB detection
- Simulate reset conditions in Docker

## Documentation

Detailed setup guides for different platforms:

- QNAP: See `docs/qnap.md` – Optimized scripts with USB detection and reset
- Synology: See `docs/synology.md` – How to reset UPS USB via cron on DSM
- General Linux & Slack Integration: See `docs/usage.md`

## GitHub Actions
- See `.github/workflows/ups-toolkit-ci.yml ` for automated test runs on commits and PRs
`.github/workflows/deploy-ghcr-k8s.yml` for  CI/CD deployment to GHCR and Kubernetes

## 🤝 Contributing
Please read [`CONTRIBUTING.md`](.github/CONTRIBUTING.md) for how to help out!

## License
Licensed under the [MIT License](LICENSE)

---

For contributions, bug reports or suggestions, please open an issue or pull request on GitHub.
