#This script sets a site to read only
#Groups: Owner, Member and Visitors
$AESKeyFilePath = "D:\SP2013\SP-Tools\ScriptCredentials\AESKeys\CMMigrate01_AES.key"
$AESKey = Get-Content $AESKeyFilePath
$credentialFilePath = "D:\SP2013\SP-Tools\ScriptCredentials\CMMigrate01.txt"
$credFiles = Get-Content $credentialFilePath
$userName = $credFiles[0]
$password = $credFiles[1] | ConvertTo-SecureString -Key $AESKey
$Credential = New-Object System.Management.Automation.PsCredential($userName,$password)
$Server = "KMLPTL06"
$session = New-PSSession -ComputerName $Server -Authentication Credssp -Credential $Credential 
#$session >> "C:\Users\SP_EU_C_P_SPCM_admin\Documents\Output\session.txt" 

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
#Input variables
##Enter source and target site URL
$SourceWebURL = "ENTER SITE URL"
##Set State = Unlock, NoAdditions, ReadOnly NoAccess
$state = "ReadOnly"







$block ={
# p1 = $SourceWebURL
# p2 = $state

 param(
		[string]$p1,
		[string]$p2

                
	    )
if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PsSnapin Microsoft.SharePoint.PowerShell
}
  Set-SPSite -Identity $p1 -LockState $p2



}

$result = Invoke-Command -session $session -ScriptBlock $block -ArgumentList $SourceWebURL, $state

Remove-PSSession -session $session
