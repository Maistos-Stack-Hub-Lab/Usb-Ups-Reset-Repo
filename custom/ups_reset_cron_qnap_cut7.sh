cat > custom/ups_reset_cron_qnap_cut7.sh << 'EOF'
#!/bin/sh
# QNAP-spezifisches Reset-Skript mit gezieltem USB-Unbind/Bind
DETECT_SCRIPT="./custom/dui_qnap_custom.sh"
LOG="/tmp/ups_reset_custom.log"

ID=$(sh $DETECT_SCRIPT | head -n 1)
if [ -n "$ID" ]; then
  echo "[$(date)] Resetting UPS $ID" >> $LOG
  echo "$ID" | tee /sys/bus/usb/drivers/usb/unbind
  sleep 60
  echo "$ID" | tee /sys/bus/usb/drivers/usb/bind
else
  echo "[$(date)] No UPS detected" >> $LOG
fi
EOF

chmod +x custom/ups_reset_cron_qnap_cut7.sh

# Alternativ:⏱ Automatisch alle 10 Minuten ausführen
# */10 * * * * /share/Public/Usb-Ups-Reset-Repo/custom/ups_reset_cron_qnap_cut7.sh >> /var/log/ups_reset_qnap.log 2>&1