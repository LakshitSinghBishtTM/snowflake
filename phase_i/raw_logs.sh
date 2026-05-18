#!/bin/bash

OUTDIR="<address redacted>/SnowflakeOperator"
mkdir -p "$OUTDIR"

DATE=$(date +"%Y-%m-%d")

journalctl -u snowflake-proxy --since "1 week ago" --output=short-iso > "$OUTDIR/snowflake_raw_week_$DATE.log"