## ====================== ##
##   @Author Duncan1106   ##
## ====================== ##
##
## This script collects information about the system, including the number of processes running,
## the amount of used usedRAM and CPU usage, and the usage of the GPU. It then outputs this information
## to a file on the user's desktop.
##


# Get system boot time
$bootuptime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime

# Calculate uptime
$currentDate = Get-Date
$uptime = $currentDate - $bootuptime
$minutesUp = $uptime.Minutes
$hoursUp = $uptime.Hours
$daysUp = $uptime.Days

# User specific desktop folder
$desktopPath = "C:\Users\dunca\Desktop\ProcessCountLog.txt"

# Clear file contents after reboot
if ($minutesUp -le 1 -and $hoursUp -eq 0 -and $daysUp -eq 0) {
    Clear-Content "$desktopPath"
}

# Process Count
$processCount = (Get-Process).Count
$timestamp = Get-Date

# Used RAM
$os =  Get-WmiObject -Class WIN32_OperatingSystem
$ramUsedGB = (($os.TotalVisibleMemorySize - $os.FreePhysicalMemory)/1024/1024)
$ramUsedGBRounded = [math]::Round($ramUsedGB,2)

# RAM usage in %
$ramUsagePercent  = ((($os.TotalVisibleMemorySize - $os.FreePhysicalMemory)*100)/ $os.TotalVisibleMemorySize)
$ramUsagePercentRounded = [math]::Round($ramUsagePercent ,2)

# CPU Usage
$cpuUsagePercent = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select-Object Average ).Average

#GPU Memory Total Use
$gpuMemoryUsageMB = (((Get-Counter "\GPU Process Memory(*)\Local Usage").CounterSamples | Where-Object CookedValue).CookedValue | Measure-Object -sum).sum
$gpuMemoryUsageMBRounded = [math]::Round($gpuMemoryUsageMB/1MB,2)

#GPU Usage
$gpuUsagePercent = (((Get-Counter "\GPU Engine(*engtype_3D)\Utilization Percentage").CounterSamples | Where-Object CookedValue).CookedValue | Measure-Object -sum).sum
$gpuUsagePercentRounded = [math]::Round($gpuUsagePercent,2)

# pack all data into a textfile
Write-Output "$timestamp  Processcount:  $processCount; Used RAM: $($ramUsedGBRounded)GB & $($ramUsagePercentRounded)%; CPU Load: $($cpuUsagePercent)%; GPU Load: $($gpuUsagePercentRounded)%; GPU Memory: $($gpuMemoryUsageMBRounded)MB" >> $DesktopPath
exit