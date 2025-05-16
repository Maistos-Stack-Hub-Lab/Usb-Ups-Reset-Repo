#!/bin/bash

UPS_IP="127.0.0.1"
COMMUNITY="public"
OID=".1.3.6.1.2.1.33.1.2.1.0"

STATUS=$(snmpget -v1 -c "$COMMUNITY" "$UPS_IP" "$OID" 2>/dev/null | awk '{print $NF}')

case "$STATUS" in
  2) echo "$(date) - UPS on normal line power." ;;
  3) echo "$(date) - UPS is on battery!" ; exit 1 ;;
  *) echo "$(date) - UPS unknown status: $STATUS" ; exit 2 ;;
esac
