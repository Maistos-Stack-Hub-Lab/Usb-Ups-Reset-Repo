#!/bin/sh
# QNAP-Optimiertes UPS Reset-Skript (nur CyberPower UPS)
LOG="/tmp/ups_reset_custom.log"
RESET_SCRIPT="/sys/bus/usb/drivers/usb"

UPS_DEV=$(common/detect_usb_id_qnap.sh)

if [ -n "$UPS_DEV" ]; then
  echo "[$(date)] Unbinding USB: $UPS_DEV" >> "$LOG"
  echo "$UPS_DEV" > "$RESET_SCRIPT/unbind"
  sleep 60
  echo "[$(date)] Binding USB: $UPS_DEV" >> "$LOG"
  echo "$UPS_DEV" > "$RESET_SCRIPT/bind"
else
  echo "[$(date)] No CyberPower UPS found." >> "$LOG"
fi
