#!/bin/bash

# =============================================================================
# Monthly Snowflake journal log
# =============================================================================

set -euo pipefail

BASE="/home/ajay/lab/snowflake/phase_ii"
OUT="$BASE/logs/monthly_logs/raw"

MONTH_START=$(date +%Y-%m-01)
MONTH=$(date +%Y-%m)

NOW=$(date +"%F %T")

mkdir -p "$OUT"

echo "[$NOW] Capturing monthly logs since $MONTH_START..."

if journalctl -u snowflake.service \
    --since "$MONTH_START 00:00" \
    --no-pager \
    > "$OUT/snowflake_monthly_raw_$MONTH.log" 2>/dev/null
then
    echo "[$NOW] Monthly log saved:"
    echo "$OUT/snowflake_monthly_raw_$MONTH.log"
else
    echo "ERROR: Failed to capture monthly journal logs" >&2
    exit 1
fi