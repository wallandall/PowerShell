##### Remove all alerts for specific user from a Web Application or a Site Collection #####

function startSelection{
  Write-Host "#################################################################"
  Write-Host "##This script removes alerts for a specific user               ##"
  Write-Host "##-------------------------------------------------------------##"
  Write-Host "## Enter 1 to remove all alerts for the entire Wep Application ##"
  Write-Host "## Enter 2 to remove alerts for a Site Collection              ##"
  Write-Host "#################################################################"
  Write-Host ""
  $input = Read-Host "Enter a number or type `"Q`" to finish." 
  Write-Host ""
  switch ($input)
  {
    "1"
	  {
	    webApplication 
	  }
    "2"
      {
	    site
	  }
    "Q"
    {
  	  exit
    }
    default  
    {  
	  Write-Warning "Invalid !nput!" 
	  Write-Host ""	
	  exit	
    }
  }
}

function webApplication{
   $WA = Read-Host "Enter the url for the WebApplication "
   $User = Read-Host "Enter the username eg: (Domain\UserName) "
   if ($WA -eq "")
   {
      Write-Warning "Incorrect URL!"
	  exit
   }
   if ($User -eq "")
   {
      Write-Warning "Incorrect User Name!"
	  exit
   }
   $SPwebApp = Get-SPWebApplication $WA
   $SpecificUser = $User
   Write-Host ""
   foreach ($SPsite in $SPwebApp.Sites)
    {
      # get the collection of webs
      foreach($SPweb in $SPsite.AllWebs) 
      {
        $alerts = $SPweb.Alerts
        # if 1 or more alerts for a particular user, Make a note of them by copying their ID to an Array
		<#if ($alert.Count -lt 1)
		{
		  Write-Host "No alerts in :" $SPSite
		}
		#>
        if ($alerts.Count -gt 0)
          {
            $myalerts = @()
            foreach ($alert in $alerts)
              {
                if ($alert.User -like $SpecificUser)
                  {
                    $myalerts += $alert
                  }
               }
               ### now we have alerts for this site, we can delete them
               foreach ($alertdel in $myalerts)
	           {			  
                 $alerts.Delete($alertdel.ID)
                 write-host "Alert removed from: " $SPsite
                 write-host "Alert Type: " $alertdel.title
				 write-host "User: " $alertdel.user
				 write-host "--------------------------------------------------------"				
               }
            }		
        }		
		$SPweb.Dispose()
    }
}


function site
{
   $S = Read-Host "Enter the url for the Site "
   $User = Read-Host "Enter the username eg: (Domain\UserName) "
   if ($S -eq "")
   {
      Write-Warning "Incorrect URL!"
	  exit
   }
   if ($User -eq "")
   {
      Write-Warning "Incorrect User Name!"
	  exit
   }
   $SPsiteCollection= Get-SPSite $S
   $SpecificUser = $User
   Write-Host "" 
      foreach($SPSite in $SPsiteCollection.AllWebs) 
      {
        $alerts = $SPSite.Alerts
        # if 1 or more alerts for a particular user, Make a note of them by copying their ID to an Array
        if ($alerts.Count -gt 0)
          {
            $myalerts = @()
            foreach ($alert in $alerts)
              {
                if ($alert.User -like $SpecificUser)
                  {
                    $myalerts += $alert
                  }
               }
               ### now we have alerts for this site, we can delete them
               foreach ($alertdel in $myalerts)
	           {
                 $alerts.Delete($alertdel.ID)
				 write-host "Alert removed from: " $SPsiteCollection
                 write-host "Alert Type: " $alertdel.title
				 write-host "User: " $alertdel.user
				 write-host "--------------------------------------------------------"
               }
            }
        }
		$SPsite.Dispose()
}
startSelection
