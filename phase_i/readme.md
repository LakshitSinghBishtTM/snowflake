# Snowflake Proxy Operator Documentation

> Personal infrastructure documentation for running a Snowflake proxy, statistics collection, and related privacy infrastructure on this machine.

---

# 1. Overview

This machine operates a **Snowflake proxy** that helps censored users access the Tor network.

Snowflake is a censorship‑circumvention system that uses WebRTC connections to route traffic from censored users into the Tor network through volunteer proxies.

Software involved:

* Tor
* Snowflake proxy
* systemd
* cron
* custom statistics scripts

Primary purpose of this setup:

* help censored users reach Tor
* measure relay contribution
* maintain reproducible operator logs

All project files are stored in:

```
<address redacted>
```

---

# 2. Directory Structure

Recommended directory layout:

```
SnowflakeOperator/
│
├── snowflake-stats.sh
├── snowflake-weekly.log
├── snowflake-monthly.log
├── snowflake-stats.csv
├── README.md
```

Descriptions:

| File                  | Purpose                      |
| --------------------- | ---------------------------- |
| snowflake-stats.sh    | statistics collection script |
| snowflake-weekly.log  | weekly human readable logs   |
| snowflake-monthly.log | monthly reports              |
| snowflake-stats.csv   | dataset for analysis         |
| README.md             | this documentation           |

---

# 3. Snowflake Proxy Service

The proxy runs as a **systemd service**.

Service name:

```
snowflake-proxy
```

Check service status:

```
systemctl status snowflake-proxy
```

Start service:

```
sudo systemctl start snowflake-proxy
```

Restart service:

```
sudo systemctl restart snowflake-proxy
```

Stop service:

```
sudo systemctl stop snowflake-proxy
```

Enable at boot:

```
sudo systemctl enable snowflake-proxy
```

Disable at boot:

```
sudo systemctl disable snowflake-proxy
```

---

# 4. Capacity Configuration

Capacity determines the maximum bandwidth the proxy may use.

Configured using systemd override:

```
sudo systemctl edit snowflake-proxy
```

Example configuration:

```
[Service]
ExecStart=
ExecStart=/usr/bin/snowflake-proxy -capacity 3000000
```

Capacity is measured in **bytes per second**.

| Bandwidth | Value   |
| --------- | ------- |
| 1 MB/s    | 1000000 |
| 2 MB/s    | 2000000 |
| 3 MB/s    | 3000000 |
| 5 MB/s    | 5000000 |

Recommended value for laptops:

```
3000000 (≈3 MB/s)
```

After editing configuration:

```
sudo systemctl daemon-reload
sudo systemctl restart snowflake-proxy
```

---

# 5. Statistics Collection Script

Script location:

```
~/<redacted>.sh
```

Purpose:

Reads system logs for the Snowflake proxy and computes relay statistics.

Metrics collected:

* total connections
* upload traffic
* download traffic
* total traffic
* active hours
* average connections per hour

Script reads data from:

```
journalctl -u snowflake-proxy
```

---

# 6. Output Data

Three files are produced.

## Weekly log

```
snowflake-weekly.log
```

Example:

```
==== WEEK 2026-03-08 ====
Connections: 1277
Upload: 22.93 GB
Download: 1.52 GB
Total Traffic: 24.45 GB
Active hours: 130
Avg connections/hour: 9.82
```

---

## Monthly log

```
snowflake-monthly.log
```

Long‑term reports.

---

## CSV dataset

```
snowflake-stats.csv
```

Format:

```
date,connections,uploadGB,downloadGB,totalGB,activeHours,avgConnPerHour
```

Example:

```
2026-03-08,1277,22.93,1.52,24.45,130,9.82
```

This dataset can be analyzed using:

* R
* Python
* Excel
* Pandas

---

# 7. Cron Automation

Statistics are generated automatically using cron.

Edit cron:

```
crontab -e
```

Entries:

```
0 0 * * 0 <address redacted>/snowflake-stats.sh
0 0 1 * * <address redacted>/snowflake-stats.sh
```

Meaning:

| Schedule           | Action        |
| ------------------ | ------------- |
| Every Sunday       | weekly stats  |
| First day of month | monthly stats |

Verify cron jobs:

```
crontab -l
```

---

# 8. Real‑Time Monitoring

Check proxy process:

```
ps aux | grep snowflake
```

View service logs:

```
journalctl -u snowflake-proxy
```

Last 50 log entries:

```
journalctl -u snowflake-proxy -n 50
```

---

# 9. Bandwidth Expectations

Approximate traffic depending on capacity.

| Capacity | Monthly Traffic |
| -------- | --------------- |
| 0.5 MB/s | 40–60 GB        |
| 2 MB/s   | 150–250 GB      |
| 3 MB/s   | 200–350 GB      |
| 5 MB/s   | 400–700 GB      |

Actual usage depends on network demand and uptime.

---

# 10. Understanding the Data

Snowflake "connections" are not unique users.

Typical relationship:

```
1 real user ≈ 3–6 connections
```

Estimated users helped:

```
users ≈ connections / 4
```

Example:

```
1277 connections ≈ ~320 users
```

---

# 11. Architecture Overview

Traffic flow:

```
Censored User
      ↓
Snowflake Proxy (this machine)
      ↓
Tor Entry Node
      ↓
Tor Network
      ↓
Destination Website
```

Proxy cannot read user traffic.

Traffic is encrypted end‑to‑end.

---

# 12. Troubleshooting

If service fails:

Check status

```
systemctl status snowflake-proxy
```

Check logs

```
journalctl -u snowflake-proxy
```

Reload configuration

```
sudo systemctl daemon-reload
sudo systemctl restart snowflake-proxy
```

---

# 13. Lifetime Metrics (optional tracking)

Possible long‑term metrics:

* total connections
* total traffic relayed
* estimated users helped

Example yearly projection:

```
1300 connections/week
≈ 67600 connections/year
≈ 11000–22000 users helped
```

---

# 14. Backup Strategy

Important files to backup:

```
/etc/systemd/system/snowflake-proxy.service.d/
~/LinuxData/Dawn/Work/Gig/SnowflakeOperator/
```

These contain:

* service configuration
* scripts
* traffic dataset

---

# 15. Migration to New Machine

Steps:

1. Install tor and snowflake-proxy

```
sudo apt install snowflake-proxy
```

2. Copy configuration

```
/etc/systemd/system/snowflake-proxy.service.d/
```

3. Copy stats directory

```
SnowflakeOperator/
```

4. Reload systemd

```
sudo systemctl daemon-reload
```

5. Enable service

```
sudo systemctl enable snowflake-proxy
```

---

# 16. Notes

* Upload traffic is usually larger than download.
* Snowflake traffic is encrypted.
* Proxy operators cannot see user activity.
* Bandwidth limits protect personal internet usage.

---

# End of Document
