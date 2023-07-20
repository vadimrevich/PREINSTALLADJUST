@echo on
rem *******************************************************
rem install.cmd
rem This Script Install Main Basic Features for a
rem Windows Server
rem 2008 R2 Datacenter Core Edition
rem
rem
rem RETURNS:	0 if Success
rem		1 if Check Integrity Folder Error
rem		2 if Check Integrity File Error
rem
rem SOURCE: <CD-ROM>:\BIN\install.cmd
rem
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=InitialAdjust
set REDACT=W2K12R2CORE
set FIRM=NIT

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem
rem Set Directories Path
set CMDSPATH=%~dp0InitialAdjust\cmd
set PWSHSPATH=%~dp0InitialAdjust\pwsh

rem Set Files Name
rem
set WPOSHEXE=%SystemRoot%\System32\WindowsPowershell\v1.0\powershell.exe
set WSCRIPTEXE=%SystemRoot%\System32\wscript.exe

set ACMD00=copy.bitsadmin.bat
set ACMD01=dism.enable-feature.netfx.cmd
set ACMD02=dism.enable-feature.powershell.cmd
set ACMD03=AllowPoShScriptsGlobal.cmd
set APWSH04=NIT-TinyExclusions.ps1
set APWSH05=smbshare-mount.ps1

echo Check Integrity...
rem
if not exist %CMDSPATH% echo "%CMDSPATH% not Exist" && exit /b 1
if not exist %PWSHSPATH% echo "%PWSHSPATH% not Exist" && exit /b 1
if not exist %WPOSHEXE% echo "%WPOSHEXE% not Exist" && exit /b 1
if not exist %WSCRIPTEXE% echo "%WSCRIPTEXE% not Exist" && exit /b 1
if not exist %COMSPEC% echo "%COMSPEC% not Exist" && exit /b 1
if not exist %CMDSPATH%\%ACMD00% echo "%CMDSPATH%\%ACMD00% not Exist" && exit /b 2
if not exist %CMDSPATH%\%ACMD01% echo "%CMDSPATH%\%ACMD01% not Exist" && exit /b 2
if not exist %CMDSPATH%\%ACMD02% echo "%CMDSPATH%\%ACMD02% not Exist" && exit /b 2
if not exist %CMDSPATH%\%ACMD03% echo "%CMDSPATH%\%ACMD03% not Exist" && exit /b 2
if not exist %PWSHSPATH%\%APWSH04% echo "%PWSHSPATH%\%APWSH04% not Exist" && exit /b 2
if not exist %PWSHSPATH%\%APWSH05% echo "%PWSHSPATH%\%APWSH05% not Exist" && exit /b 2

echo The End Checking Integrity

:Execute_Payload

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
echo Script Runs Without Elevated Privileges
rem exit /b 17
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

echo Download and Run Payload..
rem

rem call %CMDSPATH%\%ACMD00%
call %CMDSPATH%\%ACMD01%
call %CMDSPATH%\%ACMD02%
call %CMDSPATH%\%ACMD03%
if not exist %WPOSHEXE% echo "%WPOSHEXE% not Exist" && exit /b 1
%WPOSHEXE% -NoProfile -ExecutionPolicy Bypass -File %PWSHSPATH%\%APWSH04%
%WPOSHEXE% -NoProfile -ExecutionPolicy Bypass -File %PWSHSPATH%\%APWSH05%

rem End Payloads

rem The End of the Script
:End
echo End Executing A File %AFILE%
exit /b 0
