##This Script creates a Site Collection
##Enables the SharePoint CollaborationBasic Site Feature
##Creates the KM Document Library

#Manage Variables
#Site Url
$sURL = "ENTER URL"
#Site Owner
$sOwner = "ENTER USER"
#Site Template
## STS#0 = Team Site
$sTemplate = "STS#0"
#Language
## English = 1033
##German = 1031
$sLanguage = "1033"
#Name is the title of the site collection
$sName = "Test0410-2"
#Quota Template
## 1GB 
## 5GB
$sQuota = "5GB"

#Enable Feature
##Konica Minolta Lighthouse Project Site
##@@
##Konica Minolta Sharepoint 2013 - Design Collaboration
#$sFeature = "KM.SP.Design2013_DesignCollaboration"

#$sFeature = "KM.SP.Collaboration2013_BasicSiteLists"
#$sFeature = "KM.SP.Collaboration2013_SiteElements"
#$sFeature = "KM.SP.Collaboration2013_AdminPageWeb"


## Konica Minolta SharePoint 2013 - AdminPage
#$sFeature = "KM.SP.Collaboration2013_AdminPage"
#$sFeature = "KM.SP.Collaboration2013_LightHouseProjectWebElements"
$sFeature = "KM.SP.Collaboration2013_WebElements"



Add-PSSnapin Microsoft.SharePoint.PowerShell -EA SilentlyContinue

New-SPSite $sURL -OwnerAlias $sOwner -Description $sDescription -Language $sLanguage -Name $sName -Template $sTemplate -QuotaTemplate $sQuota
#Enable-SPFeature -identity $sFeature -URL $sURL
#Enable-SPFeature -identity "Konica Minolta Collaboration Basic Site" -URL "https://test-collaboration.bs.kme.intern/sites/test-0410_2"

###Enable-SPFeature FeatureFolderName -Url http://server/site/subsite
##
##Get-SPFeature  $sFeature | Enable-SPFeature -Url  $sUrl
#Get-SPSite https://test-collaboration.bs.kme.intern/sites/test-0410_2 | Get-SPWeb -Limit ALL |%{ Get-SPFeature -Web $_ } | Out-GridView –Title “All features for this site”
