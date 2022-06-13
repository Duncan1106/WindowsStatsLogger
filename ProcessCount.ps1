# Process Count
$psCount = (Get-Process).Count
$Date = Get-Date

# Used RAM
$CompObject =  Get-WmiObject -Class WIN32_OperatingSystem
$RAM = (($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)/1024/1024)
$RoundRAM = [math]::Round($RAM,2)

# Average CPU Usage
$CpuLoad = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average ).Average

echo "$Date  Processcount:  $psCount ; Used RAM: $RoundRAM ; Average CPU Load: $CpuLoad" >> C:\Users\dunca\Desktop\ProcessCountLog.txt