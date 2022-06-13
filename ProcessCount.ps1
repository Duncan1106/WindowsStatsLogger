# Process Count
$psCount = (Get-Process).Count
$Date = Get-Date

# Used RAM
$CompObject =  Get-WmiObject -Class WIN32_OperatingSystem
$RAM = (($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)/1024/1024)
$RoundRAM = [math]::Round($RAM,2)

# Average CPU Usage
$CpuLoad = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average ).Average

#GPU Memory Total Use
$GpuMemTotal = (((Get-Counter "\GPU Process Memory(*)\Local Usage").CounterSamples | where CookedValue).CookedValue | measure -sum).sum

#GPU Usage  
$GpuUseTotal = (((Get-Counter "\GPU Engine(*engtype_3D)\Utilization Percentage").CounterSamples | where CookedValue).CookedValue | measure -sum).sum

echo "$Date  Processcount:  $psCount ; Used RAM: $RoundRAM GB; Average CPU Load : $CpuLoad %; GPU Usage: $([math]::Round($GpuUseTotal,2))%; GPU Memory: $([math]::Round($GpuMemTotal/1MB,2)) MB" >> C:\Users\dunca\Desktop\ProcessCountLog.txt
