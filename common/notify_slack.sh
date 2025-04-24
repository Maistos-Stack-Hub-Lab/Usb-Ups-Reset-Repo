#!/bin/bash

WEBHOOK_URL="https://hooks.slack.com/services/your/webhook/url"
HOST=$(hostname)
TIME=$(date)
MESSAGE="$1"

[ -z "$MESSAGE" ] && MESSAGE="⚠️ Unknown anomaly detected"

PAYLOAD=$(jq -n --arg text "*UPS Alert*\nHost: $HOST\nTime: $TIME\nMessage: $MESSAGE" '{"text":$text}')

curl -s -X POST -H "Content-type: application/json" --data "$PAYLOAD" "$WEBHOOK_URL"

#Install jq via apt install jq if needed.