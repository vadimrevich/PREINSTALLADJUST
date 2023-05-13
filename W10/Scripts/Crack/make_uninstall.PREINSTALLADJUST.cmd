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
set DOTBIN=C:\.BIN

rem Set Files...
rem
set CMDFILE001=%DOTBIN%\open.smbshare.LNKDIR.cmd
set CMDFILE002=%DOTBIN%\OpenExplorerThisAsAdmin.cmd
set CMDFILE003=%DOTBIN%\OpenTerminalThisAsAdmin.cmd
set CMDFILE004=%DOTBIN%\PREINSTALLADJUST.install.cmd
set CMDFILE005=C:\open.dotBIN.dir.cmd
set CMDFILE006=%DOTBIN%\open.TestsFolder.cmd

echo Check Integrity...
rem
if not exist %WPWSHEXE% echo %WPWSHEXE% is not found && exit /b 1
if not exist %PREINSTALLDIR% echo %PREINSTALLDIR% is not found && exit /b 1
if not exist %DOTBIN% echo %DOTBIN% is not found && exit /b 1

rem
echo Download and Run Payloads...
rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
net session >nul 2>&1

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
if exist %CMDFILE001% del /F /Q %CMDFILE001% 
if exist %CMDFILE002% del /F /Q %CMDFILE002% 
if exist %CMDFILE003% del /F /Q %CMDFILE003% 
if exist %CMDFILE004% del /F /Q %CMDFILE004% 
if exist %CMDFILE005% del /F /Q %CMDFILE005% 
if exist %CMDFILE006% del /F /Q %CMDFILE006% 

:End
echo The Successful End of the Script %0
exit /b 0
