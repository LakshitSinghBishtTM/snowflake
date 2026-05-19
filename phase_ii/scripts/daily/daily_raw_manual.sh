#!/bin/bash

# =============================================================================
# Daily Snowflake journal log
# =============================================================================

set -euo pipefail

BASE="/home/ajay/lab/snowflake/phase_ii"
OUT="$BASE/logs/daily_logs/raw"

# Use argument if provided, otherwise today
TARGET="${1:-today}"

DATE=$(date -d "$TARGET" +%F)
NOW=$(date +"%F %T")

mkdir -p "$OUT"

echo "[$NOW] Capturing daily Snowflake logs for: $DATE"

if journalctl -u snowflake.service \
    --since "${DATE} 00:00:00" \
    --until "${DATE} 23:59:59" \
    --no-pager \
    > "$OUT/snowflake_daily_raw_$DATE.log" 2>/dev/null
then
    echo "[$NOW] Daily log saved:"
    echo "$OUT/snowflake_daily_raw_$DATE.log"
else
    echo "ERROR: Failed to capture daily journal logs" >&2
    exit 1
fi
