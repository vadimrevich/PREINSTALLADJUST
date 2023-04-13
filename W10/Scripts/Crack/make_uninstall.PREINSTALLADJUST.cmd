@echo on
rem *******************************************************
rem make-uninstall
rem The Command File Removes Scripts and Directory of the
rem project PREINSTALLADJUST
rem *******************************************************
@echo off

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Directory
rem

set PREINSTALLDIR=C:\.BIN\PREINSTALLADJUST
set PREPWSH=%PREINSTALLDIR%\BIN\InitialAdjust\pwsh
set WPWSHEXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe
set SMBUNINSTALLSCRIPT=smbshare-unmount0.ps1

echo Check Integrity...
rem
if not exist %WPWSHEXE% echo %WPWSHEXE% is not found && exit /b 1
if not exist %PREINSTALLDIR% echo %PREINSTALLDIR% is not found && exit /b 1

rem
echo Download and Run Payloads...
rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
exit /b 17
rem
set getadminvbs=nit-%~n0.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TPDL%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Download and Execute Payloads
rem

echo Run Payloads...

echo Delete main Files and Directories...
rem
%WPWSHEXE% -NoProfile -File %PREPWSH%\%SMBUNINSTALLSCRIPT%
rmdir >nul 2>nul /S /Q %PREINSTALLDIR%

echo Delete auxiliary Files and Directories...
rem

:End
The Successful End of the Script %0
exit /b 0
