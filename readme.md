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
├── .github/
│   ├── workflows/
│   │   └── ups-toolkit-ci.yml
│   ├── ISSUE_TEMPLATE.md
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── CONTRIBUTING.md
├── README.md
├── LICENSE
├── .gitignore
├── Dockerfile
├── docker-compose.yml
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
└── k8s/
    └── deployment.yaml
```

## 📦 Installation
```bash
git clone https://github.com/Maistos-Stack-Hub-Lab/Usb-Ups-Reset-Repo.git
cd Usb-Ups-Reset-Repo
chmod +x */*.sh
```

## 🐳 Docker Deployment
### Dockerfile
```
FROM debian:bullseye

RUN apt update && apt install -y usbutils curl jq bash

COPY . /app
WORKDIR /app

CMD ["bash"]
```

### docker-compose.yml
```
version: '3.9'

services:
  ups-toolkit:
    build: .
    container_name: ups_toolkit_local
    volumes:
      - ./logs:/app/logs
    command: [ "bash", "-c", "./common/detect_usb_id.sh && sleep infinity" ]
```

Run locally:
```bash
docker-compose up --build -d
```

## ☸️ Kubernetes Deployment (Example)
File: `k8s/deployment.yaml`
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

## 🔐 Securing CI with Google Cloud Secret Manager
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

---

This setup is now fully CI/CD-capable for Docker, Kubernetes, and enterprise secret management via Google Cloud!