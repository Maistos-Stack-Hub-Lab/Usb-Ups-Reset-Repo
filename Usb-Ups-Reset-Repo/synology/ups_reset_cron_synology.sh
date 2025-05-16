#!/bin/sh

LOGFILE="/volume1/public/usb_reset.log"

for DEV in $(lsusb | grep -i cyberpower | awk '{print $2"-"$4}' | sed 's/://'); do
  echo "$(date) - Resetting $DEV" >> "$LOGFILE"
  echo "$DEV" > /sys/bus/usb/drivers/usb/unbind
  sleep 1
  echo "$DEV" > /sys/bus/usb/drivers/usb/bind
done

echo "$(date) - USB-Reset abgeschlossen" >> "$LOGFILE"
