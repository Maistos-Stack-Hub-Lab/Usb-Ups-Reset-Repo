#!/bin/sh

# Script to detect CyberPower UPS USB IDs
# Returns device IDs like '1-1.2' needed for USB reset

LOGFILE="/tmp/usb_detect.log"
echo "[$(date)] Scanning for CyberPower UPS..." >> "$LOGFILE"

for devpath in /sys/bus/usb/devices/*; do
  if [ -f "$devpath/product" ] && grep -iq "cyberpower" "$devpath/product"; then
    echo "[$(date)] Found CyberPower device at $(basename "$devpath")" >> "$LOGFILE"
    echo "$(basename "$devpath")"
  fi
done
