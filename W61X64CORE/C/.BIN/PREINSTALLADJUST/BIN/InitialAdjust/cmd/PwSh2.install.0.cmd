%windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:NetFx2-ServerCore /norestart 
rem %windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /norestart 
%windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShell /norestart
%windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShell-WOW64 /norestart
%windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:ServerManager-PSH-Cmdlets /norestart
%windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:BestPractices-PSH-Cmdlets /norestart
rem %windir%\system32\Dism.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShellISE /norestart
