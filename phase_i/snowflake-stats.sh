#!/bin/bash

DIR="<address redacted>"

WOUT="$DIR/snowflake-weekly.log"
MOUT="$DIR/snowflake-monthly.log"
CSV="$DIR/snowflake-stats.csv"

DATE=$(date +"%Y-%m-%d")

################################
# WEEKLY DATA
################################

LOGW=$(journalctl -u snowflake-proxy --since "1 week ago")

CONNW=$(echo "$LOGW" | grep "connections." | awk '{sum += $7} END {print sum}')
UPW=$(echo "$LOGW" | grep "Traffic Relayed" | grep -oP '↑ \K[0-9]+' | awk '{sum+=$1} END {print sum/1024/1024}')
DOWNW=$(echo "$LOGW" | grep "Traffic Relayed" | grep -oP '↓ \K[0-9]+' | awk '{sum+=$1} END {print sum/1024/1024}')
HOURSW=$(echo "$LOGW" | grep -c "Traffic Relayed")

TOTALW=$(echo "$UPW + $DOWNW" | bc)

if [ "$HOURSW" -gt 0 ]; then
AVGW=$(echo "$CONNW / $HOURSW" | bc -l)
else
AVGW=0
fi

echo "==== WEEK $DATE ====" >> "$WOUT"
echo "Connections: $CONNW" >> "$WOUT"
echo "Upload: ${UPW} GB" >> "$WOUT"
echo "Download: ${DOWNW} GB" >> "$WOUT"
echo "Total Traffic: ${TOTALW} GB" >> "$WOUT"
echo "Active hours: $HOURSW" >> "$WOUT"
echo "Avg connections/hour: $AVGW" >> "$WOUT"
echo "" >> "$WOUT"

################################
# MONTHLY DATA
################################

LOGM=$(journalctl -u snowflake-proxy --since "1 month ago")

CONNM=$(echo "$LOGM" | grep "connections." | awk '{sum += $7} END {print sum}')
UPM=$(echo "$LOGM" | grep "Traffic Relayed" | grep -oP '↑ \K[0-9]+' | awk '{sum+=$1} END {print sum/1024/1024}')
DOWNM=$(echo "$LOGM" | grep "Traffic Relayed" | grep -oP '↓ \K[0-9]+' | awk '{sum+=$1} END {print sum/1024/1024}')
HOURSM=$(echo "$LOGM" | grep -c "Traffic Relayed")

TOTALM=$(echo "$UPM + $DOWNM" | bc)

if [ "$HOURSM" -gt 0 ]; then
AVGM=$(echo "$CONNM / $HOURSM" | bc -l)
else
AVGM=0
fi

echo "==== MONTH $DATE ====" >> "$MOUT"
echo "Connections: $CONNM" >> "$MOUT"
echo "Upload: ${UPM} GB" >> "$MOUT"
echo "Download: ${DOWNM} GB" >> "$MOUT"
echo "Total Traffic: ${TOTALM} GB" >> "$MOUT"
echo "Active hours: $HOURSM" >> "$MOUT"
echo "Avg connections/hour: $AVGM" >> "$MOUT"
echo "" >> "$MOUT"

################################
# CSV DATASET
################################

if [ ! -f "$CSV" ]; then
echo "date,connections,uploadGB,downloadGB,totalGB,activeHours,avgConnPerHour" >> "$CSV"
fi

echo "$DATE,$CONNW,$UPW,$DOWNW,$TOTALW,$HOURSW,$AVGW" >> "$CSV"
