@echo off
::if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
PowerShell -ExecutionPolicy Unrestricted -Command C:\Users\dunca\Desktop\ProcessCount.ps1 -windowstyle hidden
exit