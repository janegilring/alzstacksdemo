param (
  [Parameter()]
  [String]$Location = "$($env:LOCATION)",

  [Parameter()]
  [String]$ConnectivitySubscriptionId = "$($env:CONNECTIVITY_SUBSCRIPTION_ID)",

  [Parameter()]
  [String]$TemplateFile = "upstream-releases\$($env:UPSTREAM_RELEASE_VERSION)\infra-as-code\bicep\modules\orchestration\connectivityDeployment\connectivityDeployment.bicep",

  [Parameter()]
  [String]$TemplateParameterFile = 'config\custom-parameters\resourceGroupConnectivity.parameters.all.json'
)

$inputObject = @{
  Name                     = 'ALZ-Connectivity'
  ManagementGroupId        = 'psc-platform-connectivity'
  Location                 = $Location
  TemplateFile             = $TemplateFile
  TemplateParameterFile    = $TemplateParameterFile
  DeploymentSubscriptionId = $ConnectivitySubscriptionId
  DeleteAll                = $true
  Tag                      = @{Environment = 'Demo' }
  Verbose                  = $true
  DenySettingsMode         = 'DenyDelete'
  Force                    = $true
}

$StackExists = Get-AzManagementGroupDeploymentStack -Name $inputObject.Name -ManagementGroupId $inputObject.ManagementGroupId -ErrorAction SilentlyContinue

if ($StackExists) {

  Set-AzManagementGroupDeploymentStack @inputObject

} else {

  New-AzManagementGroupDeploymentStack @inputObject

}
