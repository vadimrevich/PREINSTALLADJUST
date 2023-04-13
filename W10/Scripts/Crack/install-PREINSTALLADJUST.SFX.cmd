@echo off
set SFXARCH=PREINSTALLADJUST-W10.exe
set PASS=szbeck
set FOLDER=%~dp0..
if not exist "%FOLDER%\%SFXARCH%" goto Error
"%FOLDER%\%SFXARCH%" -p%PASS%
goto Finish
:Error
echo "File %FOLDER%\%SFXARCH% not found" && exit /b 1
rem pause
:Finish
exit /b 0