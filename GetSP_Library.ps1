<#
Descriptipn:
This script Display a list of Libaries for a SharePoint Site Collection

Example:
.\Get_Lib.ps1 -url "http://sharepoint/teams/test" -outputPath "C:\test1.csv

Parameters:
-url : *Required - Specifies the URL for the  site collection . 
-outputPath : *Required - Specifies the file name and location of the output. 
#>
param
(
  [string] $url = $(throw "url-parameter is required."),
  [string] $outputPath = $(throw "outputPath-parameter is required.")
)

$Site = Get-SPSite $url
#$outputPath = "c:\Portallist.csv"
############################################################################
#                        Function                                          #
############################################################################
Function GetMyFiles($Folder)
{
 #Write-Host "Folder Name: " $Folder.Name
  $folderPath =  $Folder.Url
  ###Write-Host "Folder URl: "  $folderPath 
  foreach($file in $Folder.Files)
  {
    #Write-Host "File" $file.Name
	Write-Host "File :" $file
    Add-Content -Path $outputPath -Value  " ,$file"

  } 

  #Loop through all subfolders and call the function recursively
  foreach ($SubFolder in $Folder.SubFolders)
  {
    if($SubFolder.Name -ne "Forms")
    {
	  ##$subfolderPath = $SubFolder.Path
      #Write-Host "Sub Folder : $SubFolder.Name" -NoNewline
     # Add-Content -Path $outputPath -Value  "Folder Name : $($SubFolder.Name)"
      GetMyFiles($Subfolder)
    }
  }

}
############################################################################
#                         Main                                             #
############################################################################

 #Loop throuh all Sub Sites
 foreach($Web in $Site.AllWebs)
 {
   Write-Host "Site :" $web.URL
   Add-Content -Path $outputPath -Value  $web.URL
   #Add-Content -Path $outputPath -Value  "Website : $($web.Title)"
   foreach($list in $Web.Lists)
   {
     #Write-Host ""
     #Filter Doc Libs, Eliminate Hidden ones
     if(($List.BaseType -eq "DocumentLibrary") -and ($List.Hidden -eq $false) )
     {
       #Write-Host "--List Name: " $List.RootFolder
       #Add-Content -Path $outputPath -Value  "Library : $($List.RootFolder)"
       GetMyFiles($List.RootFolder)
     }
	 #Write-Host "_________________________________________________________________________"
   }
    Write-Host "--------------------------------------------------------------------------------------------------------------------"
 }
