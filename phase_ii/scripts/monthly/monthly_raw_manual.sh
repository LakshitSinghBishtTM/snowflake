#!/bin/bash

set -euo pipefail

BASE="/home/ajay/lab/snowflake/phase_ii"
OUT="$BASE/logs/monthly_logs/raw"

TARGET="${1:-today}"

MONTH=$(date -d "$TARGET" +%Y-%m)
MONTH_START=$(date -d "$TARGET" +%Y-%m-01)
MONTH_END=$(date -d "$MONTH_START +1 month -1 day" +%F)

NOW=$(date +"%F %T")

mkdir -p "$OUT"

echo "[$NOW] Capturing monthly logs for $MONTH..."

if journalctl -u snowflake.service \
    --since "$MONTH_START 00:00:00" \
    --until "$MONTH_END 23:59:59" \
    --no-pager \
    > "$OUT/snowflake_monthly_raw_$MONTH.log" 2>/dev/null
then
    echo "[$NOW] Monthly log saved:"
    echo "$OUT/snowflake_monthly_raw_$MONTH.log"
else
    echo "ERROR: Failed to capture monthly journal logs" >&2
    exit 1
fi
