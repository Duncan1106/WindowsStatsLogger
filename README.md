# Windows Stats Logger

A PowerShell script that logs system statistics to a text file.

## Features

Logs the following system metrics with timestamps:

- Process count
- Used RAM in GB
- RAM usage percentage
- CPU usage percentage
- GPU usage percentage
- Used GPU memory in MB

All data is saved to a text file on the user's desktop.

## How It Works

The script collects system information using PowerShell cmdlets and Windows Performance Counters, then appends the data to a log file with the current timestamp.

The log file is automatically cleared after each system reboot (detected via system uptime).

## Requirements

- Windows operating system
- PowerShell 5.1 or later
- Administrative privileges (for GPU counters on some systems)

## Installation

1. Clone the project:
   ```bash
   git clone https://github.com/Duncan1106/WindowsStatsLogger
   ```

2. Navigate to the project directory:
   ```bash
   cd WindowsStatsLogger
   ```

## Usage

### Running the script

Double-click `start.bat` or run it from command prompt:
```bash
start.bat
```

### Alternative: Run directly with PowerShell
```powershell
powershell -ExecutionPolicy Bypass -File ProcessCount.ps1
```

## Output

The script creates a `ProcessCountLog.txt` file on your desktop containing entries like:
```
08/03/2026 14:30:45 Processcount:  125; Used RAM: 8.25GB & 65.5%; CPU Load: 45%; GPU Load: 12%; GPU Memory: 256MB
```

## Troubleshooting

### GPU counters not working
- Ensure you have a dedicated GPU
- Run the script as Administrator
- GPU counters may not be available on all systems

### File not being created
- Check that you have write permissions to your Desktop folder
- Try running as Administrator

### Script fails to start
- Ensure PowerShell execution policy allows script execution
- Try: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

## Security

This project uses GitHub Actions for security scanning:

[![PSScriptAnalyzer](https://github.com/Duncan1106/WindowsStatsLogger/actions/workflows/powershell.yml/badge.svg)](https://github.com/Duncan1106/WindowsStatsLogger/actions/workflows/powershell.yml)
[![Codacy Security Scan](https://github.com/Duncan1106/WindowsStatsLogger/actions/workflows/codacy.yml/badge.svg)](https://github.com/Duncan1106/WindowsStatsLogger/actions/workflows/codacy.yml)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available for use.
