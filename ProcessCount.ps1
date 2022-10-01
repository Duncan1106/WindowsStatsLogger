## ====================== ##
##   @Author Duncan1106   ##
## ====================== ##

# Reset file after restart
$bootuptime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
$CurrentDate = Get-Date
$uptime = $CurrentDate - $bootuptime
$minutes_up = $uptime.Minutes
$hours_up = $uptime.Hours
echo "$hours_up"

# user specific desktop folder
$DesktopPath = "C:\Users\dunca\Desktop\ProcessCountLog.txt"
# $DesktopPath = [Environment]::GetFolderPath("Desktop") + "\ProcessCountLog.txt"

# one time use of clear content after reboot
if ($minutes_up -cle 1 -and $hours_up -cmatch 0){
    Clear-Content "$DesktopPath"
}

# Process Count
$psCount = (Get-Process).Count
$Date = Get-Date

# Used RAM
$CompObject =  Get-WmiObject -Class WIN32_OperatingSystem
$RAM = (($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)/1024/1024)
$RAM_R = [math]::Round($RAM,2)

# Ram usage in %
$Memory = ((($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)*100)/ $CompObject.TotalVisibleMemorySize)
$Memory_R = [math]::Round($Memory,2)

# CPU Usage
$CpuLoad = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average ).Average

#GPU Memory Total Use
$GpuMemTotal = (((Get-Counter "\GPU Process Memory(*)\Local Usage").CounterSamples | where CookedValue).CookedValue | measure -sum).sum
$GpuMemTotal_R = [math]::Round($GpuMemTotal/1MB,2)

#GPU Usage
$GpuUseTotal = (((Get-Counter "\GPU Engine(*engtype_3D)\Utilization Percentage").CounterSamples | where CookedValue).CookedValue | measure -sum).sum
$GpuuseTotal_R = [math]::Round($GpuUseTotal,2)

# pack all data into a textfile
Write-Output "$Date  Processcount:  $psCount; Used RAM: $($RAM_R)GB & $($Memory_R)%; CPU Load: $($CpuLoad)%; GPU Load: $($GpuUseTotal_R)%; GPU Memory: $($GpuMemTotal_R)MB" >> $DesktopPath
exit
exit
