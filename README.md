# Snowflake

A dataset, collection framework, and documentation resource for the Tor Snowflake Proxy.<br>
This repository contains telemetry logs, collection scripts, automation infrastructure, and supporting documentation gathered from a long-term self-hosted Snowflake deployment.

For running Snowflake and/or other bridges, please visit https://torproject.org and use [docs](phase_ii/docs/) as additional help.

## Features

- Logs are categorised as raw and summary
- Separate scripts for each logging task. Helpful for debugging
- Modularisation of infra for better separation
- Proper documentation for running Snowflake
- Continuously updated dataset
- Four months of collected data (ongoing)
- Data collected across multiple operating systems, networks and locations
- Raw logs preserved in their original form and not modified, edited, or sanitized after collection
- Data collected from a real-world self-hosted deployment
- No VPS or hosted infrastructure used to artificially increase uptime or traffic

## Phases

### Phase I - Ape (February - May)

- Simple structure
- Focuses on easy data collection
- Logs collected weekly

### Phase II - Monk (May - Present)

- Organised and modular
- Extensive documentation and help
- Logs collected on a daily, weekly and monthly basis

## Example Output

The following cummulative statistics are from [phase_i/logs/summarised/total_stats.log](phase_i/logs/summarised/total_stats.log):

```
Connections: 33457
Upload: 184.918 GB
Download: 20.013 GB
Total Traffic: 204.931 GB
Active hours: 2467
Avg connections/hour: 13.56
```

## Use

Tor volunteers are encouraged to reuse the scripts, documentation, and automation workflows provided in this repository.<br>
The dataset may be used for research and analysis with proper attribution.<br> Modified datasets and derivative works must clearly indicate changes and remain under the same license terms.

## Repository Structure

```
snowflake
├── .github
│   ├── workflows
│       ├── mirrors.yml
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
│   │   ├── distribution_manual.txt 
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

## Distribution

Snowflake is distributed across multiple Git hosting platforms. No single platform is considered authoritative for long-term availability.

The project is automatically mirrored from GitHub to the following repositories:

- GitHub (canonical): https://github.com/LakshitSinghBishtTM/snowflake
- GitLab: https://gitlab.com/lakshitsinghbishttm/snowflake
- Codeberg: https://codeberg.org/lakshitsinghbishttm/snowflake
- Gitea: https://gitea.com/LakshitSinghBishtTM/snowflake
- Bitbucket: https://bitbucket.org/lakshitsinghbishttm/snowflake
- SourceForge: https://sourceforge.net/projects/snowflaketm/

Mirrors are synchronized automatically via GitHub Actions.

## License

This repo is licensed under GNU General Public License v3.0.<br>
Datasets and telemetry logs are licensed separately under CC BY-NC-SA 4.0

For more information, please see [LICENSE](LICENSE) and [LICENSE-DATA](LICENSE-DATA)


## Reporting

If you discover any sensitive personal information within the dataset, documentation, or logs, please contact me at lakshitsinghbishttm@gmail.com and include the location of the affected content.

Reasonable requests for removal, redaction, or correction will be reviewed as soon as possible.

For bugs, script improvements, documentation issues, data-retention concerns, or other repository-related problems, please open a GitHub issue.

## Disclaimer

- This project is not funded/affiliated with or endorsed by the Tor Project.
- This project doesn't support any terrorist organisation. The hostname "isis" is purely coincidental
- No deanonymisation or sensitive data of snowflake users is logged