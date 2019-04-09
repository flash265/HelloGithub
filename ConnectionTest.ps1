
$newSiteUrl = "https://binf.sharepoint.com/sites/DepartmentSite202"

$cred = Get-AutomationPSCredential -Name "BINFSharePointOnline"


## $DenyAddAndCustomizePagesStatusEnum = [Microsoft.Online.SharePoint.TenantAdministration.DenyAddAndCustomizePagesStatus]

Add-Type -TypeDefinition @"
   public enum CustomizeStatus
   {
      Enabled,
      Disabled
   }
"@


Write-output $DenyAddAndCustomizePagesStatusEnum


Connect-PnPOnline -Url 'https://binf-admin.sharepoint.com/' -Credentials $cred

Get-PnPTenantSite -Detailed -Url $newSiteUrl | select url,DenyAddAndCustomizePages

$context = Get-PnPContext
$provisionedSite = Get-PnPTenantSite -Detailed -Url $newSiteUrl


$provisionedSite.DenyAddAndCustomizePages = [CustomizeStatus]::Disabled
## $provisionedSite.DenyAddAndCustomizePages = Disabled

$provisionedSite.Update()
$context.ExecuteQuery()

Get-PnPTenantSite -Detailed -Url $newSiteUrl | select url,DenyAddAndCustomizePages

