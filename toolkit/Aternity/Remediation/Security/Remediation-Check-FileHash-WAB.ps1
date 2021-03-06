<#
.Synopsis
   Aternity - Remediation Script: Check-Filehash-WAB
.DESCRIPTION
	Check the MD5 file hash of powerpoint
	
	References:
	* https://www.riverbed.com
	* https://help.aternity.com/search?facetreset=yes&q=remediation

.EXAMPLE
   Deploy in Aternity (Configuration > Remediation > Add Action) 
   Action Name: Check-Filehash-WAB
   Description: Check the MD5 file hash of wab
#>
 
try
{
	# Load Agent Module
    Add-Type -Path $env:STEELCENTRAL_ATERNITY_AGENT_HOME\ActionExtensionsMethods.dll
	
#region Remediation action logic

	#Set the path of the binary to check
	$app_executable_path = "C:\Program Files\Windows Mail\wab.exe" 
	try{
		$result = (Get-FileHash -Path $app_executable_path  -Algorithm  MD5).Hash
	}
	catch {
		$result = "Exception"
		
	}

#endregion

	# Set Output message
    [ActionExtensionsMethods.ActionExtensionsMethods]::SetScriptOutput($result)
}
catch
{
    [ActionExtensionsMethods.ActionExtensionsMethods]::SetFailed($_.Exception.Message)
}
