#!/bin/bash

# Check UPS status via NUT
STATUS=$(upsc ups@localhost ups.status 2>/dev/null)

if [[ "$STATUS" == *"OB"* || "$STATUS" == *"LB"* ]]; then
  echo "$(date) - UPS on Battery or Low Battery detected: $STATUS"
  exit 1
else
  echo "$(date) - UPS status OK: $STATUS"
  exit 0
fi
