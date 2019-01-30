<#
Descriptipn:
This script will list all SharePoint Site and export the following information to a csv file
1)URL
2)Title
3)1st Site Owner
4)Site Manager
6)Manager Devision
7)Site Quota
8)Quota Used
9)Last List Used (Date)
10)Last Library used (Date)


Example:
1)
.\Get_Lib.ps1 -lists "lists.csv" -outputPath "C:\test1" -option "export"
2)
.\Get_Lib.ps1 -lists "lists.csv" -outputPath "C:\test1" -option "list"

Parameters:
-list : *Required - Specifies the file with the lists to be exported. 
-outputPath : *Required - Specifies the file name, folder name and location of the output. 
-option : *Required - Allows for two option
			export: Creates a log of all exported files as well as exports files and folder structure
			list: Only creates a log of all files 

#>
#param
#(
#  [string] $url = $(throw "url-parameter is required."),
#  [string] $outputPath = $(throw "outputPath-parameter is required.")
#  
#)
if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    Add-PsSnapin Microsoft.SharePoint.PowerShell
}
$url = "ENTER URL "
$outputPath = "ENTER Fil PATH"

$fileName = "MyInfohub2.csv"
$file = "$outputPath\$fileName"
if(Test-Path $file)
{
  Write-Host "File already exists!"
  exit
}
else 
{ 
  New-Item $file -type File
  Add-Content -Path $file -Encoding UTF8 -Value "Title;URL;Date Created; Last Modified Date; Available Quota; Quota Used"
}



$webApplication = Get-SPWebApplication $url -Limit All 
$site = $webApplication.Sites

#$sites = Get-SPSite $webapplication
foreach ($s in $site)
{
      ##$test1 = $sites.Quota.Storagemaximumlevel
	  ##$test2 = $sites.Quota.StorageWarningLevel
	 ## Write-Host $test1
	  ## Write-Host $test2
	  
	  
      $root = $s.rootweb
	  #Title of the Site 
      $title = $root.title
	  #URL of the Site 
	  $siteURL = $root.url
	  #Site Descripttion
      #Write-Host $root.Description	  
	  #Date the Site was creared
	  $created = Get-Date($root.Created) -Format d  
	  #Date the site was last used.
	  $dateLastModified = Get-Date($root.LastItemModifiedDate) -Format d 
										
	  
	  
	  #Site Owner Name
	  $ownerName = $s.Owner.Name
	  #Site Owner Email
	  $ownerEmail = $s.Owner.Email
	  #Site Owner Login Name
	  $ownerLogin = $s.Owner
	  #Write-Host $sites.SecondaryOwner
	 # Write-Host $sites.SiteAdministrators
	  #Write-Host $ownerName
	 
	 
	 
	 
	  
	  
	  #Storage used in MB
	  $quotaUsed = $s.Usage.Storage / 1MB
	  #Storage available in MB
	  $quotaAvailable = $s.Quota.StorageMaximumLevel/1MB
	   #Storage available in MB
	   
	  
	  
	  
	  #Write-Host $sites.Usage.StorageMaximumLevel / 1GB
	  #Write-Host $site.Usage.StorageMaximumLevel
	  #Write-Host $web.quota
	  #Write-Host $root.QuotaTemplate
	  
	  
	  Add-Content -Path $file -Encoding UTF8 -Value "$title;$siteURL;$created;$dateLastModified;$quotaAvailable;$quotaUsed"
	  
	  
	  
	  
  
}

$site.Dispose
