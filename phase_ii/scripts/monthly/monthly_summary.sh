#!/bin/bash

# =============================================================================
# Monthly Snowflake summary log
# =============================================================================

set -euo pipefail

BASE="/home/ajay/lab/snowflake/phase_ii"
OUT="$BASE/logs/monthly_logs/summarised"

MONTH_START=$(date +%Y-%m-01)
MONTH=$(date +%Y-%m)

NOW=$(date +"%F %T")

mkdir -p "$OUT"

LOGFILE="$OUT/snowflake_monthly_summary_$MONTH.log"
TMP=$(mktemp)

echo "[$NOW] Generating monthly summary..."

journalctl -u snowflake.service \
    --since "$MONTH_START 00:00:00" \
    --no-pager > "$TMP"

# === Parsing (supports decimals) ===
CONNECTIONS=$(grep -o 'there were [0-9]* completed successful connections' "$TMP" \
| grep -o '[0-9]*' | awk '{sum += $1} END {print sum+0}')

ACTIVE_HOURS=$(grep -c "completed successful connections" "$TMP")

DOWNLOAD_KB=$(grep -o 'Traffic Relayed ↓ [0-9.]*' "$TMP" \
| grep -o '[0-9.]*' | awk '{sum += $1} END {print sum+0}')

UPLOAD_KB=$(grep -o '↑ [0-9.]*' "$TMP" \
| grep -o '[0-9.]*' | awk '{sum += $1} END {print sum+0}')

# Convert KB to GB
UPLOAD_GB=$(awk "BEGIN {printf \"%.6f\", ${UPLOAD_KB:-0}/1024/1024}")
DOWNLOAD_GB=$(awk "BEGIN {printf \"%.6f\", ${DOWNLOAD_KB:-0}/1024/1024}")
TOTAL_GB=$(awk "BEGIN {printf \"%.6f\", ${UPLOAD_GB} + ${DOWNLOAD_GB}}")

AVG_CONN=$(awk "BEGIN {if (${ACTIVE_HOURS:-0} > 0) printf \"%.2f\", ${CONNECTIONS:-0}/${ACTIVE_HOURS:-0}; else print 0}")

# Write summary
{
echo "==== MONTH $MONTH ===="
echo "Connections: $CONNECTIONS"
echo "Upload: $UPLOAD_GB GB"
echo "Download: $DOWNLOAD_GB GB"
echo "Total Traffic: $TOTAL_GB GB"
echo "Active hours: $ACTIVE_HOURS"
echo "Avg connections/hour: $AVG_CONN"
} > "$LOGFILE"

rm -f "$TMP"

echo "[$NOW] Monthly summary saved:"
echo "$LOGFILE"