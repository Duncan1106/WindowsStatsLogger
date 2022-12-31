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
$CurrentDate = Get-Date
$uptime = $CurrentDate - $bootuptime
$minutes_up = $uptime.Minutes
$hours_up = $uptime.Hours
$days_up = $uptime.Days

# User specific desktop folder
$desktopPath = "C:\Users\dunca\Desktop\ProcessCountLog.txt"

# Clear file contents after reboot
if ($minutes_up -le 1 -and $hours_up -eq 0 -and $days_up -eq 0) {
    Clear-Content "$desktopPath"
}

# Process Count
$psCount = (Get-Process).Count
$Date = Get-Date

# Used usedRAM
$os =  Get-WmiObject -Class WIN32_OperatingSystem
$usedRAM = (($os.TotalVisibleMemorySize - $os.FreePhysicalMemory)/1024/1024)
$usedRAMRounded = [math]::Round($usedRAM,2)

# usedRAM usage in %
$ramUsage  = ((($os.TotalVisibleMemorySize - $os.FreePhysicalMemory)*100)/ $os.TotalVisibleMemorySize)
$ramUsageRounded = [math]::Round($ramUsage ,2)

# CPU Usage
$cpuUsage = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select-Object Average ).Average

#GPU Memory Total Use
$gpuMemoryUsage = (((Get-Counter "\GPU Process Memory(*)\Local Usage").CounterSamples | Where-Object CookedValue).CookedValue | Measure-Object -sum).sum
$gpuMemoryUsageRounded = [math]::Round($gpuMemoryUsage/1MB,2)

#GPU Usage
$gpuUsage = (((Get-Counter "\GPU Engine(*engtype_3D)\Utilization Percentage").CounterSamples | Where-Object CookedValue).CookedValue | Measure-Object -sum).sum
$gpuUsageRounded = [math]::Round($gpuUsage,2)

# pack all data into a textfile
Write-Output "$Date  Processcount:  $psCount; Used usedRAM: $($usedRAMRounded)GB & $($ramUsageRounded)%; CPU Load: $($cpuUsage)%; GPU Load: $($gpuUsageRounded)%; GPU Memory: $($gpuMemoryUsageRounded)MB" >> $DesktopPath
exit

