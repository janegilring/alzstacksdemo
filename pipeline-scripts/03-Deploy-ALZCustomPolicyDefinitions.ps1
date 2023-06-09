param (
  [Parameter()]
  [String]$Location = "$($env:LOCATION)",

  [Parameter()]
  [String]$TopLevelMGPrefix = "$($env:TOP_LEVEL_MG_PREFIX)",

  [Parameter()]
  [String]$TemplateFile = "upstream-releases\$($env:UPSTREAM_RELEASE_VERSION)\infra-as-code\bicep\modules\policy\definitions\customPolicyDefinitions.bicep",

  [Parameter()]
  [String]$TemplateParameterFile = "config\custom-parameters\customPolicyDefinitions.parameters.all.json"
)
$inputObject = @{
  Name                     = 'ALZ-Policies'
  ManagementGroupId        = $TopLevelMGPrefix
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
