#!/bin/sh
# Soft USB reset script for QNAP with CyberPower UPS

LOGFILE="/tmp/ups_reset_soft.log"
DETECT_LOG="/tmp/usb_detect.log"
VENDOR_ID="0764"  # CyberPower

echo "[$(date)] Starting soft USB reset..." >> "$LOGFILE"

# Get current device path
USB_DEV=$(lsusb | grep "$VENDOR_ID" | awk '{print $2 "-" $4}' | sed 's/://')
if [ -z "$USB_DEV" ]; then
    echo "[$(date)] No CyberPower UPS found." >> "$LOGFILE"
    exit 1
fi

echo "[$(date)] Found CyberPower UPS at USB port: $USB_DEV" >> "$LOGFILE"

# Soft restart: try unbind/rebind from USB driver
DEV_PATH=$(readlink -f /sys/bus/usb/devices/"$USB_DEV")
DEV_NAME=$(basename "$DEV_PATH")

echo "$DEV_NAME" > /sys/bus/usb/drivers/usb/unbind
sleep 2
echo "$DEV_NAME" > /sys/bus/usb/drivers/usb/bind

echo "[$(date)] Rebound USB device $DEV_NAME" >> "$LOGFILE"

# Optional: Restart QNAP UPS service (if available)
if [ -x /etc/init.d/ups-usb ]; then
    echo "[$(date)] Restarting QNAP UPS service..." >> "$LOGFILE"
    /etc/init.d/ups-usb restart >> "$LOGFILE" 2>&1
else
    echo "[$(date)] Warning: QNAP UPS init script not found." >> "$LOGFILE"
fi

echo "[$(date)] Soft USB reset finished." >> "$LOGFILE"
