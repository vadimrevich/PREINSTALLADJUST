@echo on
rem *******************************************************
rem open.smbshare.LNKDIR.cmd
rem This Command File Opens an C:\.BIN\smbshare\LNK
rem directory at Explorer and Terminal
rem file for Load a platform-independent adjustments
rem *******************************************************
@echo off

rem Set the Variables...
rem
set CMDFOLDER=C:\.BIN\smbshare\LNK
set CMDFILE01=%CMDFOLDER%\OpenExplorerThisAsAdmin.cmd
set CMDFILE02=%CMDFOLDER%\OpenTerminalThisAsAdmin.cmd

echo Check Integrity...
rem
if not exist %CMDFOLDER% echo %CMDFOLDER% is not Found && exit /b 1

echo Run Payload...
rem
call %CMDFILE01%
call %CMDFILE02%

:End
echo The End of the Script %0
exit /b 0