param (
  [Parameter()]
  [String]$Location = "$($env:LOCATION)",

  [Parameter()]
  [String]$ConnectivitySubscriptionId = "$($env:CONNECTIVITY_SUBSCRIPTION_ID)",

  [Parameter()]
  [String]$TemplateFile = "upstream-releases\$($env:UPSTREAM_RELEASE_VERSION)\infra-as-code\bicep\modules\connectivityDeployment/connectivityDeployment.bicep",

  [Parameter()]
  [String]$TemplateParameterFile = 'config\custom-parameters\connectivityDeployment.parameters.all.json'
)

<#
# Parameters necessary for deployment
$inputObject = @{
  DeploymentName        = 'alz-ConnectivityRGDeploy-{0}' -f ( -join (Get-Date -Format 'yyyyMMddTHHMMssffffZ')[0..63])
  Location              = $Location
  TemplateFile          = $TemplateFile
  TemplateParameterFile = $TemplateParameterFile
  Verbose               = $true
}

Select-AzSubscription -SubscriptionId $ConnectivitySubscriptionId

New-AzSubscriptionDeployment @inputObject
#>

$inputObject = @{
  Name                     = 'ALZ-Connectivity}'
  ManagementGroupId        = 'alz-platform-connectivity'
  Location                 = $Location
  TemplateFile             = $TemplateFile
  TemplateParameterFile    = $TemplateParameterFile
  DeploymentSubscriptionId = $ConnectivitySubscriptionId
  DeleteAll                = $true
  Tag                      = @{Environment = 'Demo' }
  Verbose                  = $true
  DenySettingsMode         = 'DenyDelete'
}

New-AzManagementGroupDeploymentStack @inputObject