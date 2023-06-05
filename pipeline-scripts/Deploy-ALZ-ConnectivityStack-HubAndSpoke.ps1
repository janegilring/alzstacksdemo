param (
  [Parameter()]
  [String]$Location = "$($env:LOCATION)",

  [Parameter()]
  [String]$ConnectivitySubscriptionId = "$($env:CONNECTIVITY_SUBSCRIPTION_ID)",

  [Parameter()]
  [String]$TemplateFile = "upstream-releases\$($env:UPSTREAM_RELEASE_VERSION)\infra-as-code\bicep\modules\orchestration\resourceGroup.bicep",
  connectivityDeployment/connectivityDeployment.bicep
  [Parameter()]
  [String]$TemplateParameterFile = 'config\custom-parameters\resourceGroupConnectivity.parameters.all.json'
)



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