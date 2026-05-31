# Snowflake

A simple architecture and dataset for Tor Snowflake Proxy.<br>
Designed as a supplementary resource for locally running a Snowflake proxy.

For running Snowflake and/or other bridges, please visit https://torproject.org and use phase_ii/docs/ as additional help.

## Use

For running Snowflake and script related things, other Tor Volunteers are highly encouraged and can use the scripts freely along with documentation and other help available.<br>
The dataset can be used for research and analysis with proper attribution.<br>
Modified datasets or derivative works must clearly indicate changes and remain under the same license terms.

## Repository Structure

```
snowflake
├── DATA_LICENSE
├── LICENSE
├── README.md
├── phase_i
│   ├── docs
│   │   ├── host_warning.txt
│   │   ├── README.md
│   │   └── TIMING.txt
│   ├── logs
│   │   ├── raw
│   │   └── summarised
│   ├── scripts
│   │   ├── raw_logs.sh
│   │   ├── raw_logs_to_analysis.py
│   │   └── snowflake-stats.sh
│   └── system
│       └── os-and-kernel-logs
│           └── dist-upgrade
├── phase_ii
│   ├── docs
│   │   ├── cron.txt
│   │   ├── downtime.txt
│   │   ├── duration.txt
│   │   ├── install.txt
│   │   ├── lost_data.txt
│   │   ├── output.txt
│   │   ├── reading_order.txt
│   │   ├── scripts.txt
│   │   ├── systemctl.txt
│   │   ├── systemd_logging.txt
│   │   └── systemd.txt
│   ├── logs
│   │   ├── daily_logs
│   │   │   ├── raw
│   │   │   └── summarised
│   │   ├── monthly_logs
│   │   │   ├── raw
│   │   │   └── summarised
│   │   └── weekly_logs
│   │       ├── raw
│   │       └── summarised
│   ├── metadata
│   │   ├── hardware.txt
│   │   ├── host.txt
│   │   ├── network.txt
│   │   ├── reading_order.txt
│   │   ├── software.txt
│   │   └── specs.txt
│   ├── scripts
│   │   ├── daily
│   │   ├── monthly
│   │   └── weekly
│   └── systemd
│       ├── services
│       └── timers
```

## Phases

### Phase I - Ape (February - May)

- Simple structure
- Focuses on easy data collection
- Logs collected weekly

### Phase II - Monk (May - Present)

- Organised and modular
- Extensive documentation and help
- Logs collected on a daily, weekly and monthly basis

## Features

- Logs are categorised as raw and summary
- Separate scripts for each logging task. Helpful for debugging
- Modularisation of infra for better separation
- Proper documentation for running snowflake
- Updated and real dataset
- Data collected across multiple operating systems, networks and locations
- 4 months data and still counting
- No vps or remote server for artificial inflation. Real world deployment

## Example Output

The following output is from snowflake/phase_i/snowflake-weekly.log containing polished weekly stats:

```
==== WEEK 2026-04-12 ====
Connections: 1914
Upload: 14.2735 GB
Download: 0.488194 GB
Total Traffic: 14.761694 GB
Active hours: 167
Avg connections/hour: 11.46107784431137724550
```
 
## License

This repo is licensed under GNU General Public License v3.0
Datasets and telemetry logs are licensed separately under CC BY-NC-SA 4.0

For more information, please check LICENSE and LICENSE_DATA


## Reporting

If any of my sensitive data or info is available on the dataset, then please email at lakshitsinghbishttm@gmail.com along with the location of sensitive info. Mail will be answered as soon as possible.

For improvement in scripts, data retention, documentation and other problems, please use issues of GitHub.

## Disclaimer

- This project is not funded/affiliated with or endorsed by the Tor Project.
- This project doesn't support any terrorist organisation. Hostname being isis is purely coincidental
- No deanonymisation or sensitive data of snowflake users is logged
