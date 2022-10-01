
# Windows Stats Logger

Saves some informations from the taskmanager to a txt file.


## Features

Saves: 
    
    - Process count
    - Used Ram in Gb
    - Used Ram in %
    - CPU Usage in %
    - GPU Usage
    - Used GPU Memory
    
to a textfile with the current time stamp 


## Optimizations

The txt file will be cleared after each reboot,(checking with uptime) an simple shutdown and start computer via Windows is not enough for that.


## Run Locally

Clone the project

```bash
  git clone https://github.com/Duncan1106/WindowsStatsLogger
```

Go to the project directory

```bash
  cd WindowsStatsLogger
```

Start the server

```bash
  start.bat
```

## Security

[![PSScriptAnalyzer](https://github.com/Duncan1106/WindowsStatsLogger/actions/workflows/powershell.yml/badge.svg)](https://github.com/Duncan1106/WindowsStatsLogger/actions/workflows/powershell.yml)
[![Codacy Security Scan](https://github.com/Duncan1106/WindowsStatsLogger/actions/workflows/codacy.yml/badge.svg)](https://github.com/Duncan1106/WindowsStatsLogger/actions/workflows/codacy.yml)
