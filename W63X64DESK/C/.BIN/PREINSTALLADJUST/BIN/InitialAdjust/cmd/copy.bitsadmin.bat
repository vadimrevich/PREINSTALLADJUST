@echo on
rem *******************************************************
rem copy.bitsadmin.bat
rem This Script Copies bitsadmin.exe File
rem in the Target Directory if not Exist there
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
set REDACT=W2K12R2CORE
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
set AFILE=bitsadmin.exe
set WSCRIPTEXE=%pathCMD%\WScript.exe
rem set AFILE=1.txt

echo Check if FileSystem correct...
rem
echo Check if Folder Presents...
if not exist %SystemRoot% echo "%SystemRoot% not Exist" && exit /b 1
if not exist "%TPDL%" echo "TEMP not Exist" && exit /b 1
if not exist %pathCMD% echo %pathCMD% not Exist && exit /b 1
if not exist %WSCRIPTEXE% echo %WSCRIPTEXE% not Exist && exit /b 2

echo Check if bitsadmin.exe is Found in the Current Directory
rem
if exist %~dp0%AFILE% goto Check_File_Sys_Exist
echo %~dp0%AFILE% doesn't Exist
exit /b 2

:Check_File_SyS_Exist
echo Check if bitsadmin.exe is Found in a %pathCMD% Directory...
if not exist %pathCMD%\%AFILE% goto Coping_File
echo %pathCMD%\%AFILE% is already Exist
exit /b 0

:Coping_file
echo End System Files Check!

echo Download and Run Payload..
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


rem copy /B /V /-Y %~dp0%AFILE% %pathCMD%

rem End Payloads

rem The End of the Script
:End
echo End Copy A File %AFILE%
exit /b 0
