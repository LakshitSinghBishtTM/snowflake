#!/bin/bash

# =============================================================================
# Weekly Snowflake journal log
# =============================================================================

set -euo pipefail

BASE="/home/ajay/lab/snowflake/phase_ii"
OUT="$BASE/logs/weekly_logs/raw"

START=$(date -d "7 days ago" +%F)
END=$(date +%F)

NOW=$(date +"%F %T")

mkdir -p "$OUT"

echo "[$NOW] Capturing weekly logs from $START 00:00:00 to $END 00:00:00..."

if journalctl -u snowflake.service \
    --since "$START 00:00:00" \
    --until "$END 00:00:00" \
    --no-pager \
    > "$OUT/snowflake_weekly_raw_${START}_to_${END}.log" 2>/dev/null
then
    echo "[$NOW] Weekly log saved:"
    echo "$OUT/snowflake_weekly_raw_${START}_to_${END}.log"
else
    echo "ERROR: Failed to capture weekly journal logs" >&2
    exit 1
fi