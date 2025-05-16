#!/bin/sh

LOGFILE="/share/Public/usb_reset.log"

for DEV in $(ls /sys/bus/usb/drivers/usb/*-*/driver | cut -d/ -f6); do
  echo "$(date) - Resetting $DEV" >> "$LOGFILE"
  echo "$DEV" > /sys/bus/usb/drivers/usb/unbind
  sleep 1
  echo "$DEV" > /sys/bus/usb/drivers/usb/bind
done

echo "$(date) - USB-Reset abgeschlossen" >> "$LOGFILE"
