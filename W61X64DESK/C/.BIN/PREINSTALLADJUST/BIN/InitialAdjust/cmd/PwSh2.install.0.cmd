rem %windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:NetFx2-ServerCore /norestart 
%windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /norestart 
rem %windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShell /norestart
rem %windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShell-WOW64 /norestart
rem %windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:ServerManager-PSH-Cmdlets /norestart
rem %windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:BestPractices-PSH-Cmdlets /norestart
%windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShellISE /norestart
