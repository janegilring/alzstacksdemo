param (
  [Parameter()]
  [String]$Location = "$($env:LOCATION)",

  [Parameter()]
  [String]$ManagementSubscriptionId = "$($env:MANAGEMENT_SUBSCRIPTION_ID)",

  [Parameter()]
  [String]$TopLevelMGPrefix = "$($env:TOP_LEVEL_MG_PREFIX)",

  [Parameter()]
  [String]$TemplateFile = "upstream-releases\$($env:UPSTREAM_RELEASE_VERSION)\infra-as-code\bicep\orchestration\policyDeployment\policyDeployment.bicep",

  [Parameter()]
  [String]$TemplateParameterFile = "config\custom-parameters\policyDeployment.parameters.all.json"
)
$inputObject = @{
  Name                     = 'ALZ-Policies'
  ManagementGroupId        = 'fd91810c-57b4-43e3-b513-c2a81e8d6a27' #'Tenant Root Group'
  Location                 = $Location
  TemplateFile             = $TemplateFile
  TemplateParameterFile    = $TemplateParameterFile
  DeploymentSubscriptionId = $ManagementSubscriptionId
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
