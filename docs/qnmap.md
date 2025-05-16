mkdir -p docs

cat > docs/qnap.md << 'EOF'
# QNAP Integration – USB UPS Reset Toolkit

Diese Anleitung erklärt, wie Sie das Toolkit speziell auf QNAP-Systemen mit CyberPower USVs (z. B. BR1200ELCD) einsetzen können.

##  Problem
QNAP erkennt die USV nach bestimmten Systemabfragen (z. B. durch `get_log`-Skripte) nicht mehr oder meldet „Anomal“ oder „Power Loss“.

## Lösung
Nutzen Sie die speziell angepassten Skripte:

- `custom/dui_qnap_custom.sh` – erkennt gezielt CyberPower-Geräte anhand der USB-Vendor-ID
- `custom/ups_reset_cron_qnap_cut7.sh` – führt einen gezielten USB-Reset **nur** für die USV durch

## Alternativ:⏱ Automatisch alle 10 Minuten ausführen
*/10 * * * * /share/Public/Usb-Ups-Reset-Repo/custom/ups_reset_cron_qnap_cut7.sh >> /var/log/ups_reset_qnap.log 2>&1

## Einrichtung (SSH)

```bash
cd /share/Public/
git clone https://github.com/Maistos-Stack-Hub-Lab/Usb-Ups-Reset-Repo.git
cd Usb-Ups-Reset-Repo
chmod +x custom/*.sh
