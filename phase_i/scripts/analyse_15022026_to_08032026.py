#!/usr/bin/env python3

import re
from datetime import datetime
from collections import defaultdict

LOGFILE = "rawlogs15feb8mar.txt"

pattern = re.compile(
    r'(\d{4}/\d{2}/\d{2}) \d{2}:\d{2}:\d{2} '
    r'In the last 1h0m0s, there were (\d+) connections\. '
    r'Traffic Relayed ↑ (\d+) KB, ↓ (\d+) KB'
)

weekly = defaultdict(lambda: {
    "connections": 0,
    "upload_kb": 0,
    "download_kb": 0,
    "hours": 0,
})

total_connections = 0
total_upload = 0
total_download = 0
total_hours = 0


def kb_to_gb(kb):
    return kb / 1024 / 1024


with open(LOGFILE, "r", encoding="utf-8", errors="ignore") as f:
    for line in f:
        m = pattern.search(line)
        if not m:
            continue

        date_str, conn, up, down = m.groups()

        dt = datetime.strptime(date_str, "%Y/%m/%d")

        iso_year, iso_week, _ = dt.isocalendar()

        # Monday of this ISO week
        week_start = datetime.fromisocalendar(
            iso_year, iso_week, 1
        ).date()

        conn = int(conn)
        up = int(up)
        down = int(down)

        weekly[week_start]["connections"] += conn
        weekly[week_start]["upload_kb"] += up
        weekly[week_start]["download_kb"] += down
        weekly[week_start]["hours"] += 1

        total_connections += conn
        total_upload += up
        total_download += down
        total_hours += 1


print("==== TOTAL ====")
print(f"Connections: {total_connections}")
print(f"Upload: {kb_to_gb(total_upload):.5f} GB")
print(f"Download: {kb_to_gb(total_download):.5f} GB")
print(f"Total Traffic: {kb_to_gb(total_upload + total_download):.5f} GB")
print(f"Active hours: {total_hours}")
print(f"Avg connections/hour: {total_connections / total_hours:.20f}")
print()

for week_start in sorted(weekly):
    data = weekly[week_start]

    upload_gb = kb_to_gb(data["upload_kb"])
    download_gb = kb_to_gb(data["download_kb"])
    total_gb = upload_gb + download_gb

    print(f"==== WEEK {week_start} ====")
    print(f"Connections: {data['connections']}")
    print(f"Upload: {upload_gb:.5f} GB")
    print(f"Download: {download_gb:.5f} GB")
    print(f"Total Traffic: {total_gb:.5f} GB")
    print(f"Active hours: {data['hours']}")
    print(
        f"Avg connections/hour: "
        f"{data['connections'] / data['hours']:.20f}"
    )
    print()