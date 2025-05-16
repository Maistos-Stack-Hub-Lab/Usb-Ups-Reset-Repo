
### Datei: common/detect_usb_id_qnap.sh
#!/bin/sh
# Optimiertes Detection-Skript für QNAP NAS (CyberPower UPS)
LOGFILE="/tmp/usb_detect.log"
echo "[$(date)] Scanning for CyberPower UPS..." >> "$LOGFILE"

for devpath in /sys/bus/usb/devices/*; do
  if [ -f "$devpath/idVendor" ] && grep -iq "0764" "$devpath/idVendor"; then
    echo "[$(date)] Found CyberPower device $(cat "$devpath/product") at $(basename "$devpath")" >> "$LOGFILE"
    echo "$(basename "$devpath")"
  fi
done

### Datei: qnap/ups_reset_cron_qnap_optimized.sh
#!/bin/sh
# Reset-Skript für QNAP NAS, das nur die USV zurücksetzt
LOGFILE="/tmp/ups_reset.log"

# Detection aufrufen und ID speichern
RESET_ID=$(sh /share/Public/usv/Usb-Ups-Reset-Repo-main/common/detect_usb_id_qnap.sh | head -n 1)

if [ -n "$RESET_ID" ]; then
  echo "[$(date)] Resetting USB ID $RESET_ID..." >> "$LOGFILE"
  echo "$RESET_ID" > /sys/bus/usb/drivers/usb/unbind
  sleep 5
  echo "$RESET_ID" > /sys/bus/usb/drivers/usb/bind
  echo "[$(date)] Reset complete." >> "$LOGFILE"
else
  echo "[$(date)] No CyberPower USB device found." >> "$LOGFILE"
fi