# USB UPS Reset Toolkit Documentation
<meta name="keywords" content="ups, cyberpower, linux, qnap, synology, usb, docker, kubernetes, devops, slack alerts, snmp, nut, monitoring">


Welcome to the official documentation for the **CyberPower USB UPS Reset Toolkit**. This toolkit helps automate detection, reset, and monitoring of CyberPower UPS devices via USB on Linux-based systems, including QNAP, Synology, and Docker/Kubernetes environments.

## 🚀 Features
- Auto-detection of CyberPower USB UPS devices
- USB reset scripting
- Slack webhook integration for alerts
- NUT/SNMP compatibility
- Cronjob-ready setup
- Docker & Kubernetes deployment templates
- Secure CI/CD integration with GitHub Actions & GHCR
- Google Cloud Secret Manager support

## 🛠️ Quick Start
1. **Clone the repository**:
   ```bash
   git clone https://github.com/Maistos-Stack-Hub-Lab/Usb-Ups-Reset-Repo.git
   cd Usb-Ups-Reset-Repo
   chmod +x */*.sh
   ```

2. **Run detection script**:
   ```bash
   ./common/detect_usb_id.sh
   ```

3. **Add to cron (optional)**:
   ```bash
   */10 * * * * /path/to/common/detect_usb_id.sh >> /var/log/ups-check.log 2>&1
   ```

## ☸️ Kubernetes Setup
Deploy with the sample manifest:
```bash
kubectl apply -f k8s/deployment.yaml
```

## 📦 Docker Usage
```bash
docker-compose up --build -d
```

## 🔐 Secret Management
Store Slack tokens or SSH keys securely in Google Cloud Secret Manager. Example CI usage:
```yaml
- uses: google-github-actions/auth@v1
  with:
    credentials_json: '${{ secrets.GCP_CREDENTIALS }}'
```

## 🔎 SEO Keywords
```
cyberpower ups usb monitoring linux automation docker kubernetes qnap synology devops github-actions nut snmp energy-management slack-alerts powerpanel nas iot tools server-scripts cron job reset reboot
```

## 📚 More Info
- [GitHub Repository](https://github.com/Maistos-Stack-Hub-Lab/Usb-Ups-Reset-Repo)
- [README.md](../README.md)

---

> This documentation is hosted via GitHub Pages.
> For deployment instructions, visit **Settings > Pages** and select `main` > `/docs`.


