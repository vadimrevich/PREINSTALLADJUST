<#
.SYNOPSIS
    This Script Sets a Downloaded Scripts Acls
.DESCRIPTION
    This Script Sets a Downloaded Scripts Acls
.NOTES
    File name: Set-ScriptAcl-003.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2023-03-18
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2023-03-18) Script created
    1.0.1 - 
#>

### Define System Function

function Test-IsAdmin {
    try {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
        return $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
    } catch {
        throw "Failed to determine if the current user has elevated privileges. The error was: '{0}'." -f $_
    }
}

############################################################
# Set-ScriptAcl-003.ps1
# This Script Sets a Downloaded Scripts Acls
############################################################

### Check System Conditions
#
$isAdmin = Test-IsAdmin

### Run Algorythm

if( $isAdmin ){

### === Script body === ###

# Make Owner of Scripts an Administrators Group
&takeown /F C:\.BIN\*.* /R /A

# Set ACL on Downloaded Files...
# Full Access for Administrators (SID S-1-5-32-544)
&icacls C:\.BIN\smbshare\*.* /grant *S-1-5-32-544:F /t /C
# Full Access for Computer Administrator
$sid = Get-LocalUser | Select SID | Where SID -Like "*-500"
$sid1="*"+($sid).SID + ":F"
&icacls C:\.BIN\smbshare\*.* /grant $sid1 /t /C
#
&icacls C:\.BIN\smbshare\*.* /grant vagrant:F /t /C
&icacls C:\.BIN\smbshare\*.* /grant yuden:F /t /C
&icacls C:\.BIN\smbshare\*.* /grant mssqlsr:F /t /C
# Full Access for Everyone (SID S-1-1-0)
&icacls C:\.BIN\smbshare\*.* /grant *S-1-1-0:F /t /C

### === End Script Body === ###

    Write-Host Successful Script Run!
    # return 0
}
else {
	Write-Host Warning! Script must be Run with Elevated Privileges!
	# return 17;
}
