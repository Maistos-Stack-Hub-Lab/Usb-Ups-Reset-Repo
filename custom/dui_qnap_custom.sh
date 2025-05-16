cat > custom/dui_qnap_custom.sh << 'EOF'
#!/bin/sh
# Angepasstes Erkennungs-Skript für QNAP-Systeme mit CyberPower BR1200ELCD
LOGFILE="/tmp/usb_detect.log"
echo "[$(date)] Scanning for CyberPower UPS..." >> "$LOGFILE"
for devpath in /sys/bus/usb/devices/*; do
  if [ -f "$devpath/idVendor" ] && grep -iq "0764" "$devpath/idVendor"; then
    echo "[$(date)] Found CyberPower device $(cat "$devpath/product") at $(basename "$devpath")" >> "$LOGFILE"
    echo "$(basename "$devpath")"
  fi
done
EOF

chmod +x custom/dui_qnap_custom.sh
