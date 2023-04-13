@echo on
rem *******************************************************
rem dism.enable-feature.netfx.cmd
rem This Script Enables all NetFx Featueres at Windows Server
rem 2022 Datacenter Edition
rem
rem RETURNS:	0 if Success
rem		1 if Check Integrity Folder Error
rem		2 if Check Integrity File Error
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=InitialAdjust
set REDACT=W2K22
set FIRM=NIT

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem
rem Set Directories Path
set pathCMD=%SystemRoot%\System32
set curdirforurl=%CD%
rem Set a File Name
rem
set PAR1=%1
set WSCRIPTEXE=%pathCMD%\WScript.exe
set AFILE=DISM.exe

echo Check if FileSystem correct...
rem
echo Check if Folder Presents...
if not exist %SystemRoot% echo "%SystemRoot% not Exist" && exit /b 1
if not exist "%TPDL%" echo "TEMP not Exist" && exit /b 1
if not exist %pathCMD% echo %pathCMD% not Exist && exit /b 1

rem Check if System File Present at FileSystem
echo check if System File Present...

:Check_File_SyS_Exist
if not exist %WSCRIPTEXE% echo %WSCRIPTEXE% not Exist && exit /b 2
echo Check if %AFILE% is Found in the %pathCMD% Directory...
rem
if exist %pathCMD%\%AFILE% goto Execute_Payload
echo %pathCMD%\%AFILE% is not Exist
exit /b 2

:Execute_Payload
echo End System Files Check!

echo Download and Run Payload..
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

rem Download and Execute Payloads
rem

echo Run Payloads...

set DISMEXE=%pathCMD%\%AFILE%

%DISMEXE% /Online /Enable-Feature /FeatureName:NetFx3 /All
%DISMEXE% /Online /Enable-Feature /FeatureName:NetFx4 /All
%DISMEXE% /Online /Enable-Feature /FeatureName:NetFx4-AdvSrvs /All
%DISMEXE% /Online /Enable-Feature /FeatureName:NetFx3ServerFeatures /All
%DISMEXE% /Online /Enable-Feature /FeatureName:NetFx4ServerFeatures /All

rem End Payloads

rem The End of the Script
:End
echo End Executing A File %AFILE%
exit /b 0
