#!/bin/bash

# =============================================================================
# Weekly Snowflake summary log
# =============================================================================

set -euo pipefail

BASE="/home/ajay/lab/snowflake/phase_ii"
OUT="$BASE/logs/weekly_logs/summarised"

START=$(date -d "7 days ago" +%F)
END=$(date +%F)

NOW=$(date +"%F %T")

mkdir -p "$OUT"

LOGFILE="$OUT/snowflake_weekly_summary_${START}_to_${END}.log"
TMP=$(mktemp)

echo "[$NOW] Generating weekly summary for $START to $END..."

journalctl -u snowflake.service \
    --since "$START 00:00:00" \
    --until "$END 00:00:00" \
    --no-pager > "$TMP"

CONNECTIONS=$(grep -o 'there were [0-9]* completed successful connections' "$TMP" \
| grep -o '[0-9]*' | awk '{sum += $1} END {print sum+0}')

ACTIVE_HOURS=$(grep -c "completed successful connections" "$TMP")

DOWNLOAD_KB=$(grep -o 'Traffic Relayed ↓ [0-9.]*' "$TMP" \
| grep -o '[0-9.]*' | awk '{sum += $1} END {print sum+0}')

UPLOAD_KB=$(grep -o '↑ [0-9.]*' "$TMP" \
| grep -o '[0-9.]*' | awk '{sum += $1} END {print sum+0}')

UPLOAD_GB=$(awk "BEGIN {printf \"%.6f\", ${UPLOAD_KB:-0}/1024/1024}")
DOWNLOAD_GB=$(awk "BEGIN {printf \"%.6f\", ${DOWNLOAD_KB:-0}/1024/1024}")
TOTAL_GB=$(awk "BEGIN {printf \"%.6f\", ${UPLOAD_GB} + ${DOWNLOAD_GB}}")

AVG_CONN=$(awk "BEGIN {if (${ACTIVE_HOURS:-0} > 0) printf \"%.2f\", ${CONNECTIONS:-0}/${ACTIVE_HOURS:-0}; else print 0}")

{
echo "==== WEEK $START to $END ===="
echo "Connections: $CONNECTIONS"
echo "Upload: $UPLOAD_GB GB"
echo "Download: $DOWNLOAD_GB GB"
echo "Total Traffic: $TOTAL_GB GB"
echo "Active hours: $ACTIVE_HOURS"
echo "Avg connections/hour: $AVG_CONN"
} > "$LOGFILE"

rm -f "$TMP"

echo "[$NOW] Weekly summary saved:"
echo "$LOGFILE"