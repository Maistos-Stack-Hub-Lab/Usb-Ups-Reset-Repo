#!/bin/bash

WEBHOOK_URL="https://hooks.slack.com/services/your/webhook/url"
MESSAGE="$1"

if [ -z "$MESSAGE" ]; then
  echo "No message provided." >&2
  exit 1
fi

PAYLOAD=$(jq -n --arg text "$MESSAGE" '{"text":$text}')

curl -s -X POST -H "Content-type: application/json" --data "$PAYLOAD" "$WEBHOOK_URL" \
  || echo "[$(date)] Slack webhook failed." >> /var/log/usb_reset.log

#Install jq via apt install jq if needed.