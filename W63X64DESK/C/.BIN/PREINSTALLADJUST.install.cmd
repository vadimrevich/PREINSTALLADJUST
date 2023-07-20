@echo on
rem *******************************************************
rem PREINSTALLADJUST.install.cmd
rem This Command File Runs an C:\.BIN\PREINSTALLADJUST\BIN\install.cmd
rem file for Load a platform-independent adjustments
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=PREINSTALLADJUST
set PRODUCT_NAME_FOLDER=
set FIRM=NIT
set PREINSTAD=%~dp0PREINSTALLADJUST

echo Check OS Version and Processor Architecture...
rem
rem Set OS Architecture
Set xOS=x64& If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86

set OS_ARCH=%xOS%

rem Set the Variables...
rem
set CMDFILE01=%PREINSTAD%\BIN\install.cmd
set CMDFILE02=%PREINSTAD%\BIN\Test001.preinstalladjust.files.bat
set MSGFILE01=%PREINSTAD%\BIN\Msg000.CheckIntegrity.Err00.wsf
set MSGFILE02=%PREINSTAD%\BIN\Msg000.CheckIntegrity.Err01.wsf
set MSGFILE03=%PREINSTAD%\BIN\Msg000.CheckIntegrity.Err02.wsf

echo Check Integrity...
rem
if not exist %CMDFILE01% echo %CMDFILE01% is not Found && exit /b 1
if not exist %CMDFILE02% echo %CMDFILE02% is not Found && exit /b 1
if not exist %MSGFILE01% echo %MSGFILE01% is not Found && exit /b 1
if not exist %MSGFILE02% echo %MSGFILE02% is not Found && exit /b 1
if not exist %MSGFILE03% echo %MSGFILE03% is not Found && exit /b 1

echo Run Payload...
rem
call %CMDFILE02%
call %CMDFILE01%

:End
echo The End of the Script %0
exit /b 0