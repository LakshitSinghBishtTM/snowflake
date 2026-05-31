#!/usr/bin/env python3

import re
import sys

connections = 0
download_kb = 0.0
upload_kb = 0.0
active_hours = 0

with open(sys.argv[1], "r", encoding="utf-8", errors="ignore") as f:
    for line in f:

        m = re.search(
            r"there were (\d+) completed connections.*?↓\s*([\d.]+)\s*KB.*?↑\s*([\d.]+)\s*KB",
            line,
        )

        if m:
            connections += int(m.group(1))
            download_kb += float(m.group(2))
            upload_kb += float(m.group(3))
            active_hours += 1

download_gb = download_kb / (1024 * 1024)
upload_gb = upload_kb / (1024 * 1024)
total_gb = download_gb + upload_gb

avg_conn = (
    connections / active_hours
    if active_hours > 0
    else 0
)

print("==== SUMMARY ====")
print(f"Connections: {connections}")
print(f"Upload: {upload_gb:.6f} GB")
print(f"Download: {download_gb:.6f} GB")
print(f"Total Traffic: {total_gb:.6f} GB")
print(f"Active hours: {active_hours}")
print(f"Avg connections/hour: {avg_conn:.10f}")